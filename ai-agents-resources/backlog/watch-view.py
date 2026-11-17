#!/usr/bin/env python3
"""Keep backlog/view.html up to date, and let its buttons mark tasks done or won't fix.

Runs in the background (launch agent com.cyril.backlog-view). It does two things:
- it rebuilds view.html when a backlog file changes;
- it answers POST /status on 127.0.0.1 only, so the page can change a task's status.
Only requests from the page (Origin "null", a file opened from disk) or from a command line
without an Origin are accepted, so a web page on the internet cannot change the backlogs.
"""

import datetime
import importlib.util
import json
import os
import re
import subprocess
import sys
import threading
import time
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

POLL_SECONDS = 2
HOST = "127.0.0.1"
PORT = 8765
ALLOWED_STATUSES = ("done", "wontfix")
IDENTIFIER_PATTERN = re.compile(r"^[UA]-\d+$")
SOURCE_FILES = ["user-backlog.md", "agent-findings.md"]
BACKLOG_DIRECTORY = os.path.dirname(os.path.abspath(__file__))
GENERATOR_PATH = os.path.join(BACKLOG_DIRECTORY, "build-view.py")
ARCHIVE_SCRIPT_PATH = os.path.join(BACKLOG_DIRECTORY, "archive-resolved.py")
write_lock = threading.Lock()


def load_generator():
	specification = importlib.util.spec_from_file_location("build_view", GENERATOR_PATH)
	module = importlib.util.module_from_spec(specification)
	specification.loader.exec_module(module)
	return module


def watched_files(generator):
	files = [os.path.join(BACKLOG_DIRECTORY, name) for name in generator.SOURCE_LABELS]
	archive_directory = os.path.join(BACKLOG_DIRECTORY, "archive")
	files += [os.path.join(archive_directory, name) for name in sorted(os.listdir(archive_directory))]
	return files


def signature(paths):
	return tuple((path, os.path.getmtime(path) if os.path.exists(path) else 0) for path in paths)


def set_field(lines, field, value):
	prefix = "- **" + field + ":**"
	for index, line in enumerate(lines):
		if line.startswith(prefix):
			lines[index] = prefix + " " + value
			return
	lines.insert(len(lines), prefix + " " + value)


def mark_in_file(path, identifier, status, today):
	with open(path, encoding="utf-8") as file:
		lines = file.read().split("\n")
	heading = "## " + identifier + " "
	start = next((index for index, line in enumerate(lines) if line.startswith(heading)), None)
	if start is None:
		return False
	end = start + 1
	while end < len(lines) and lines[end].startswith("- **"):
		end += 1
	fields = lines[start + 1:end]
	set_field(fields, "Status", status)
	set_field(fields, "Resolved", today)
	lines[start + 1:end] = fields
	with open(path, "w", encoding="utf-8") as file:
		file.write("\n".join(lines))
	return True


def mark_status(identifier, status, generator):
	today = datetime.date.today().isoformat()
	with write_lock:
		for name in SOURCE_FILES:
			if mark_in_file(os.path.join(BACKLOG_DIRECTORY, name), identifier, status, today):
				subprocess.run([sys.executable, ARCHIVE_SCRIPT_PATH], cwd=BACKLOG_DIRECTORY, check=True, capture_output=True)
				generator.write_page()
				return True
	return False


class StatusHandler(BaseHTTPRequestHandler):
	generator = None

	def origin_is_allowed(self):
		origin = self.headers.get("Origin")
		return origin is None or origin == "null"

	def send_json(self, code, body, origin):
		payload = json.dumps(body).encode("utf-8")
		self.send_response(code)
		if origin is not None:
			self.send_header("Access-Control-Allow-Origin", origin)
		self.send_header("Content-Type", "application/json; charset=utf-8")
		self.send_header("Content-Length", str(len(payload)))
		self.end_headers()
		self.wfile.write(payload)

	def do_OPTIONS(self):
		if not self.origin_is_allowed():
			self.send_json(403, {"error": "origin not allowed"}, None)
			return
		origin = self.headers.get("Origin")
		self.send_response(204)
		if origin is not None:
			self.send_header("Access-Control-Allow-Origin", origin)
			self.send_header("Access-Control-Allow-Methods", "POST, OPTIONS")
			self.send_header("Access-Control-Allow-Headers", "Content-Type")
		self.end_headers()

	def do_POST(self):
		origin = self.headers.get("Origin")
		if not self.origin_is_allowed():
			self.send_json(403, {"error": "origin not allowed"}, None)
			return
		if self.path != "/status":
			self.send_json(404, {"error": "unknown path"}, origin)
			return
		try:
			request = json.loads(self.rfile.read(int(self.headers.get("Content-Length", "0"))) or "{}")
		except ValueError:
			self.send_json(400, {"error": "body is not JSON"}, origin)
			return
		identifier = request.get("id", "")
		status = request.get("status", "")
		if not IDENTIFIER_PATTERN.match(identifier) or status not in ALLOWED_STATUSES:
			self.send_json(400, {"error": "need an id like U-012 and a status done or wontfix"}, origin)
			return
		if mark_status(identifier, status, self.generator):
			self.send_json(200, {"ok": True, "id": identifier, "status": status}, origin)
		else:
			self.send_json(404, {"error": identifier + " not found"}, origin)

	def log_message(self, format_string, *arguments):
		return


def serve_status(generator):
	StatusHandler.generator = generator
	server = ThreadingHTTPServer((HOST, PORT), StatusHandler)
	server.serve_forever()


def main():
	generator = load_generator()
	threading.Thread(target=serve_status, args=(generator,), daemon=True).start()
	previous = None
	while True:
		current = signature(watched_files(generator))
		if current != previous:
			with write_lock:
				generator.write_page()
			previous = current
			print("rebuilt view.html at " + time.strftime("%H:%M:%S"), flush=True)
		time.sleep(POLL_SECONDS)


if __name__ == "__main__":
	main()
