#!/usr/bin/env python3
"""Keep backlog/view.html up to date by rebuilding it when a backlog file changes.

Polls the modification times every few seconds, so it needs no extra dependency.
Meant to run in the background, for example as a launch agent.
"""

import importlib.util
import os
import time

POLL_SECONDS = 2
BACKLOG_DIRECTORY = os.path.dirname(os.path.abspath(__file__))
GENERATOR_PATH = os.path.join(BACKLOG_DIRECTORY, "build-view.py")


def load_generator():
	specification = importlib.util.spec_from_file_location("build_view", GENERATOR_PATH)
	module = importlib.util.module_from_spec(specification)
	specification.loader.exec_module(module)
	return module


def watched_files(generator):
	files = list(generator.SOURCE_LABELS)
	files = [os.path.join(BACKLOG_DIRECTORY, name) for name in files]
	files += [os.path.join(BACKLOG_DIRECTORY, "archive", name) for name in sorted(os.listdir(os.path.join(BACKLOG_DIRECTORY, "archive")))]
	return files


def signature(paths):
	return tuple((path, os.path.getmtime(path) if os.path.exists(path) else 0) for path in paths)


def main():
	generator = load_generator()
	previous = None
	while True:
		current = signature(watched_files(generator))
		if current != previous:
			generator.write_page()
			previous = current
			print("rebuilt view.html at " + time.strftime("%H:%M:%S"), flush=True)
		time.sleep(POLL_SECONDS)


if __name__ == "__main__":
	main()
