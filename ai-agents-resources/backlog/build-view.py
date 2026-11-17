#!/usr/bin/env python3
"""Write backlog/view.html, a static page that browses and filters the backlogs.

The page is self-contained and opens from disk. Run watch-view.py to keep it up to date.
"""

import glob
import json
import os
import re

BACKLOG_DIRECTORY = os.path.dirname(os.path.abspath(__file__))
OUTPUT_PATH = os.path.join(BACKLOG_DIRECTORY, "view.html")
REFRESH_SECONDS = 5
HEADING_PATTERN = re.compile(r"^## ([UA]-\d+) — (.*)$")
FIELD_PATTERN = re.compile(r"^- \*\*([A-Za-z ]+):\*\* ?(.*)$")
SOURCE_LABELS = {
	"user-backlog.md": "Cross-session tasks",
	"agent-findings.md": "Claude tasks",
}


def parse_entries(path, source_label, archived):
	entries = []
	current = None
	with open(path, encoding="utf-8") as file:
		for line in file:
			line = line.rstrip("\n")
			heading = HEADING_PATTERN.match(line)
			if heading:
				current = {"id": heading.group(1), "title": heading.group(2), "source": source_label, "archived": archived}
				entries.append(current)
				continue
			field = FIELD_PATTERN.match(line)
			if current is not None and field:
				current[field.group(1).strip().lower()] = field.group(2).strip()
	return entries


def collect_entries():
	entries = []
	for name, label in SOURCE_LABELS.items():
		entries += parse_entries(os.path.join(BACKLOG_DIRECTORY, name), label, archived=False)
	for path in sorted(glob.glob(os.path.join(BACKLOG_DIRECTORY, "archive", "*.md"))):
		entries += parse_entries(path, "Archive", archived=True)
	return entries


TEMPLATE = """<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="refresh" content="__REFRESH__">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Backlog view</title>
<style>
:root {
	--background: #fef9f4;
	--surface: #ffffff;
	--text: #3a2e26;
	--muted: #7a6558;
	--border: #ecdfd2;
	--accent: #d9770b;
	--stripe: #fbf2ea;
	--hover: #f8eadc;
}
@media (prefers-color-scheme: dark) {
	:root:not([data-theme="light"]) {
		--background: #2f2620;
		--surface: #372d26;
		--text: #f7ecdf;
		--muted: #cdb8a4;
		--border: #5a4a3e;
		--accent: #f0a060;
		--stripe: #3d332b;
		--hover: #463c33;
	}
}
:root[data-theme="dark"] {
	--background: #2f2620;
	--surface: #372d26;
	--text: #f7ecdf;
	--muted: #cdb8a4;
	--border: #5a4a3e;
	--accent: #f0a060;
	--stripe: #3d332b;
	--hover: #463c33;
}
body {
	margin: 0;
	padding: 16px;
	background: var(--background);
	color: var(--text);
	font: 15px/1.5 -apple-system, BlinkMacSystemFont, "Helvetica Neue", Arial, sans-serif;
}
h1 { font-size: 22px; margin: 0 0 14px; }
.tabs { display: flex; flex-wrap: wrap; gap: 4px; border-bottom: 1px solid var(--border); margin-bottom: 14px; }
.tab {
	padding: 10px 16px;
	border: none;
	border-bottom: 3px solid transparent;
	background: none;
	color: var(--muted);
	font: inherit;
	cursor: pointer;
}
.tab:hover { color: var(--text); }
.tab[aria-selected="true"] { color: var(--text); border-bottom-color: var(--accent); }
.filters {
	display: flex;
	flex-wrap: wrap;
	gap: 10px;
	margin-bottom: 14px;
}
.filters label { display: flex; flex-direction: column; color: var(--muted); font-size: 13px; }
select, input {
	margin-top: 3px;
	padding: 6px 10px;
	border: 1px solid var(--border);
	border-radius: 8px;
	background: var(--surface);
	color: var(--text);
	font: inherit;
	min-width: 120px;
}
select:focus, input:focus { outline: 2px solid var(--accent); outline-offset: 1px; }
.count { color: var(--muted); margin: 6px 0 12px; font-size: 13px; }
.table-wrap { border: 1px solid var(--border); border-radius: 10px; background: var(--surface); }
table { border-collapse: collapse; width: 100%; }
th, td { text-align: left; padding: 10px 12px; border-bottom: 1px solid var(--border); vertical-align: top; }
th {
	position: sticky;
	top: 0;
	z-index: 1;
	background: var(--surface);
	color: var(--muted);
	font-weight: 600;
	font-size: 13px;
	white-space: nowrap;
}
th.sortable { cursor: pointer; user-select: none; }
th.sortable:hover { color: var(--text); }
tr:last-child td { border-bottom: none; }
tbody tr:nth-child(even) { background: var(--stripe); }
tbody tr.entry { cursor: pointer; }
tbody tr.entry:hover { background: var(--hover); }
tr.details td { white-space: normal; }
.id { font-family: ui-monospace, Menlo, monospace; white-space: nowrap; color: var(--muted); font-size: 13px; }
.pill {
	display: inline-block;
	margin: 2px 5px 2px 0;
	padding: 2px 9px;
	border-radius: 999px;
	font-size: 12.5px;
	font-weight: 600;
	white-space: nowrap;
	color: var(--pill);
	background: color-mix(in srgb, var(--pill) 18%, transparent);
}
button.pill { border: none; font: inherit; font-size: 12.5px; font-weight: 600; cursor: pointer; }
button.pill:hover { outline: 1px solid var(--pill); }
.pill[role="button"] { cursor: pointer; }
.toggle { display: inline-block; width: 1.2em; color: var(--muted); }
td.meta-title { font-weight: 700; }
.progress { display: inline-flex; align-items: center; gap: 6px; margin-left: 8px; vertical-align: middle; }
.progress-track { display: inline-block; width: 90px; height: 8px; border-radius: 4px; background: var(--border); overflow: hidden; }
.progress-fill { display: block; height: 100%; background: #2e9e4f; }
.progress-label { color: var(--muted); font-size: 13px; white-space: nowrap; }
.actions { display: flex; flex-wrap: wrap; align-items: center; gap: 8px; margin-bottom: 10px; }
button.action {
	padding: 5px 14px;
	border: 1px solid var(--border);
	border-radius: 8px;
	background: var(--surface);
	color: var(--text);
	font: inherit;
	cursor: pointer;
}
button.action:hover:not(:disabled) { border-color: var(--accent); color: var(--accent); }
button.action:disabled { opacity: 0.45; cursor: default; }
.action-message { color: var(--muted); font-size: 13px; }
dl.details { display: grid; grid-template-columns: max-content 1fr; gap: 6px 18px; margin: 0; }
dl.details dt { color: var(--muted); font-size: 13px; }
dl.details dd { margin: 0; white-space: pre-wrap; }
.empty { padding: 28px; text-align: center; color: var(--muted); }
@media (max-width: 600px) {
	.table-wrap { overflow-x: auto; }
	.filters label, select, input { min-width: 0; width: 100%; }
	.filters label { flex: 1 1 140px; }
}
</style>
</head>
<body>
<h1>Backlog view</h1>
<div class="tabs" id="tabs" role="tablist"></div>
<div class="filters">
	<label>Search <input id="search" type="search" placeholder="Title, summary, area"></label>
	<select id="source" hidden></select>
	<label>Status <select id="status"></select></label>
	<label>Project / tag <select id="tag"></select></label>
	<label>Priority <select id="priority"></select></label>
	<label>Difficulty <select id="difficulty"></select></label>
</div>
<div class="count" id="count"></div>
<div class="table-wrap">
	<table>
		<thead>
			<tr>
				<th class="sortable" data-key="id">ID</th>
				<th class="sortable" data-key="title">Title</th>
				<th class="sortable" data-key="status">Status</th>
				<th class="sortable" data-key="tags">Tags</th>
				<th class="sortable" data-key="priority">Priority</th>
				<th class="sortable" data-key="difficulty">Difficulty</th>
			</tr>
		</thead>
		<tbody id="rows"></tbody>
	</table>
	<div class="empty" id="empty" hidden>No entry matches these filters.</div>
</div>
<script>
const entries = __DATA__;
const tabNames = ["Cross-session tasks", "Claude tasks", "Archive"];
const filterIdentifiers = ["search", "source", "status", "tag", "priority", "difficulty"];
const savedFilterKey = "backlog-view-filters";
const allValue = "";
const rankings = {
	priority: { low: 1, medium: 2, high: 3 },
	difficulty: { easy: 1, medium: 2, hard: 3 }
};
const statusColors = { open: "#3b7fd1", "in-progress": "#d69a0b", done: "#2e9e4f", wontfix: "#8a8a85" };
const priorityColors = { low: "#2e9e4f", medium: "#d69a0b", high: "#d64545" };
const difficultyColors = { easy: "#2e9e4f", medium: "#d69a0b", hard: "#d64545" };
const tagColors = {
	pharo: "#2e9e4f",
	perso: "#e0801c",
	moose: "#3b7fd1",
	documentation: "#d6509a",
	mcp: "#8a58d6",
	claude: "#5a64d6",
	telescope: "#1f9aa0"
};
const fallbackColors = ["#0f9fb0", "#a8862b", "#b5472b", "#6b8e23", "#7a5c3e", "#c24f8a"];
let sortState = { key: "id", direction: "asc" };
let expandedIds = new Set();
let collapsedIds = new Set();
let savedScroll = null;
const hiddenDetailFields = ["id", "title", "source", "archived"];

function splitTags(entry) {
	return (entry.tags || "").split(",").map(tag => tag.trim()).filter(tag => tag.length > 0);
}

function tagColor(tag) {
	const key = tag.toLowerCase();
	if (tagColors[key]) return tagColors[key];
	let hash = 0;
	for (const character of key) hash += character.charCodeAt(0);
	return fallbackColors[hash % fallbackColors.length];
}

function colorFor(key, value) {
	const colorTables = { status: statusColors, priority: priorityColors, difficulty: difficultyColors };
	return (colorTables[key] || {})[value] || "#8a8a85";
}

function makePill(text, color) {
	const pill = document.createElement("span");
	pill.className = "pill";
	pill.style.setProperty("--pill", color);
	pill.textContent = text;
	return pill;
}

function distinctValues(key) {
	const values = new Set();
	entries.forEach(entry => {
		if (key === "tags") {
			splitTags(entry).forEach(tag => values.add(tag));
		} else if (entry[key]) {
			values.add(entry[key]);
		}
	});
	return [...values].sort((first, second) => first.localeCompare(second));
}

function fillSourceSelect(element) {
	element.innerHTML = "";
	tabNames.forEach(name => element.add(new Option(name, name)));
}

function fillSelect(element, label, values) {
	element.innerHTML = "";
	element.add(new Option("All " + label, allValue));
	values.forEach(value => element.add(new Option(value, value)));
}

function renderTabs() {
	const container = document.getElementById("tabs");
	const selected = document.getElementById("source").value;
	container.innerHTML = "";
	tabNames.forEach(name => {
		const button = document.createElement("button");
		button.className = "tab";
		button.setAttribute("role", "tab");
		button.setAttribute("aria-selected", String(name === selected));
		button.textContent = name;
		button.addEventListener("click", () => {
			document.getElementById("source").value = name;
			saveFilters();
			render();
		});
		container.appendChild(button);
	});
}

function currentFilters() {
	return {
		search: document.getElementById("search").value.trim().toLowerCase(),
		source: document.getElementById("source").value,
		status: document.getElementById("status").value,
		tag: document.getElementById("tag").value,
		priority: document.getElementById("priority").value,
		difficulty: document.getElementById("difficulty").value
	};
}

function matches(entry, filters) {
	if (filters.source && entry.source !== filters.source) return false;
	if (filters.status && entry.status !== filters.status) return false;
	if (filters.tag && !splitTags(entry).includes(filters.tag)) return false;
	if (filters.priority && entry.priority !== filters.priority) return false;
	if (filters.difficulty && entry.difficulty !== filters.difficulty) return false;
	if (filters.search) {
		const haystack = [entry.id, entry.title, entry.summary, entry.area, entry.tags].join(" ").toLowerCase();
		if (!haystack.includes(filters.search)) return false;
	}
	return true;
}

function sortKey(entry, key) {
	if (rankings[key]) return rankings[key][entry[key]] || 99;
	if (key === "id") return entry.id.charAt(0) + entry.id.slice(2).padStart(4, "0");
	if (key === "tags") return (splitTags(entry)[0] || "").toLowerCase();
	return (entry[key] || "").toLowerCase();
}

function compareEntries(first, second) {
	const firstKey = sortKey(first, sortState.key);
	const secondKey = sortKey(second, sortState.key);
	let order = 0;
	if (firstKey < secondKey) order = -1;
	if (firstKey > secondKey) order = 1;
	return sortState.direction === "asc" ? order : -order;
}

function tagCell(entry) {
	const cellElement = document.createElement("td");
	splitTags(entry).forEach(tag => {
		const button = makePill(tag, tagColor(tag));
		button.setAttribute("role", "button");
		button.title = "Filter on " + tag;
		button.addEventListener("click", () => filterOnPill("tag", tag));
		cellElement.appendChild(button);
	});
	return cellElement;
}

function filterOnPill(filterIdentifier, value) {
	const selector = document.getElementById(filterIdentifier);
	selector.value = selector.value === value ? allValue : value;
	saveFilters();
	render();
}

function coloredCell(key, value) {
	const cellElement = document.createElement("td");
	if (value) {
		const pill = makePill(value, colorFor(key, value));
		pill.setAttribute("role", "button");
		pill.title = "Filter on " + value;
		pill.addEventListener("click", () => filterOnPill(key, value));
		cellElement.appendChild(pill);
	}
	return cellElement;
}

function plainCell(text, className) {
	const cellElement = document.createElement("td");
	cellElement.textContent = text || "";
	if (className) cellElement.className = className;
	return cellElement;
}

function updateHeaders() {
	document.querySelectorAll("th.sortable").forEach(header => {
		const label = header.textContent.replace(/ [▲▼]$/, "");
		const active = header.dataset.key === sortState.key && !isUnsorted();
		header.textContent = active ? label + (sortState.direction === "asc" ? " ▲" : " ▼") : label;
	});
}

const writeServiceAddress = "http://127.0.0.1:8765/status";

function setStatus(identifier, status, message) {
	message.textContent = "Saving...";
	fetch(writeServiceAddress, {
		method: "POST",
		headers: { "Content-Type": "application/json" },
		body: JSON.stringify({ id: identifier, status: status })
	}).then(response => response.json().then(body => {
		if (!response.ok) throw new Error(body.error || "request failed");
		message.textContent = identifier + " marked " + status + ".";
		render();
	})).catch(error => {
		message.textContent = "Not saved: " + error.message + ". Is the watcher running (launch agent com.cyril.backlog-view)?";
	});
}

function actionRow(entry) {
	const actions = document.createElement("div");
	actions.className = "actions";
	const message = document.createElement("span");
	message.className = "action-message";
	[["done", "Mark done"], ["wontfix", "Won't fix"]].forEach(([status, label]) => {
		const button = document.createElement("button");
		button.className = "action";
		button.textContent = label;
		button.disabled = entry.status === status;
		button.addEventListener("click", () => setStatus(entry.id, status, message));
		actions.appendChild(button);
	});
	actions.appendChild(message);
	return actions;
}

function detailRow(entry) {
	const row = document.createElement("tr");
	row.className = "details";
	const cellElement = document.createElement("td");
	cellElement.colSpan = 6;
	cellElement.appendChild(actionRow(entry));
	const list = document.createElement("dl");
	list.className = "details";
	Object.keys(entry).filter(key => !hiddenDetailFields.includes(key)).forEach(key => {
		const term = document.createElement("dt");
		term.textContent = key;
		const description = document.createElement("dd");
		description.textContent = entry[key];
		list.appendChild(term);
		list.appendChild(description);
	});
	cellElement.appendChild(list);
	row.appendChild(cellElement);
	return row;
}

function toggleEntry(identifier) {
	if (expandedIds.has(identifier)) {
		expandedIds.delete(identifier);
	} else {
		expandedIds.add(identifier);
	}
	saveFilters();
	render();
}

function childrenOf(parentIdentifier, visibleEntries) {
	return visibleEntries.filter(entry => entry.parent === parentIdentifier);
}

function isClosed(entry) {
	return entry.status === "done" || entry.status === "wontfix";
}

function progressBar(children) {
	const closed = children.filter(isClosed).length;
	const percentage = Math.round((closed / children.length) * 100);
	const wrapper = document.createElement("span");
	wrapper.className = "progress";
	wrapper.title = closed + " of " + children.length + " subtasks closed";
	const track = document.createElement("span");
	track.className = "progress-track";
	const fill = document.createElement("span");
	fill.className = "progress-fill";
	fill.style.width = percentage + "%";
	track.appendChild(fill);
	const label = document.createElement("span");
	label.className = "progress-label";
	label.textContent = closed + "/" + children.length;
	wrapper.appendChild(track);
	wrapper.appendChild(label);
	return wrapper;
}

function appendEntryRows(body, entry, depth, visibleEntries, visibleIds) {
	const children = childrenOf(entry.id, visibleEntries);
	const row = document.createElement("tr");
	row.className = "entry";
	row.addEventListener("click", event => {
		if (event.target.closest(".pill, .toggle")) return;
		toggleEntry(entry.id);
	});
	const titleCell = plainCell("");
	titleCell.style.paddingLeft = (10 + depth * 22) + "px";
	if (children.length > 0) {
		const toggle = document.createElement("span");
		toggle.className = "toggle";
		toggle.textContent = collapsedIds.has(entry.id) ? "▸ " : "▾ ";
		toggle.addEventListener("click", () => toggleCollapse(entry.id));
		titleCell.appendChild(toggle);
	}
	titleCell.appendChild(document.createTextNode(entry.title));
	const allChildren = entries.filter(child => child.parent === entry.id);
	if (allChildren.length > 0) {
		titleCell.classList.add("meta-title");
		titleCell.appendChild(progressBar(allChildren));
	}
	if (entry.summary) titleCell.title = entry.summary;
	const idCell = plainCell(entry.id, "id");
	row.appendChild(idCell);
	row.appendChild(titleCell);
	row.appendChild(coloredCell("status", entry.status));
	row.appendChild(tagCell(entry));
	row.appendChild(coloredCell("priority", entry.priority));
	row.appendChild(coloredCell("difficulty", entry.difficulty));
	body.appendChild(row);
	if (expandedIds.has(entry.id)) body.appendChild(detailRow(entry));
	if (!collapsedIds.has(entry.id)) {
		children.forEach(child => appendEntryRows(body, child, depth + 1, visibleEntries, visibleIds));
	}
}

function render() {
	const filters = currentFilters();
	const visible = entries.filter(entry => matches(entry, filters)).sort(compareEntries);
	const visibleIds = new Set(visible.map(entry => entry.id));
	const roots = visible.filter(entry => !entry.parent || !visibleIds.has(entry.parent));
	const body = document.getElementById("rows");
	body.innerHTML = "";
	roots.forEach(entry => appendEntryRows(body, entry, 0, visible, visibleIds));
	renderTabs();
	updateHeaders();
	document.getElementById("count").textContent = visible.length + " of " + entries.length + " entries";
	document.getElementById("empty").hidden = visible.length > 0;
}

function toggleCollapse(identifier) {
	if (collapsedIds.has(identifier)) {
		collapsedIds.delete(identifier);
	} else {
		collapsedIds.add(identifier);
	}
	saveFilters();
	render();
}

function sortBy(key) {
	if (sortState.key !== key) {
		sortState = { key: key, direction: "asc" };
	} else if (sortState.direction === "asc") {
		sortState = { key: key, direction: "desc" };
	} else {
		sortState = { key: unsortedState.key, direction: unsortedState.direction };
	}
	saveFilters();
	render();
}

function loadSavedFilters() {
	try {
		return JSON.parse(localStorage.getItem(savedFilterKey)) || {};
	} catch (error) {
		return {};
	}
}

function saveFilters() {
	const saved = { sort: sortState, expanded: [...expandedIds], collapsed: [...collapsedIds], scroll: window.scrollY };
	filterIdentifiers.forEach(identifier => saved[identifier] = document.getElementById(identifier).value);
	try {
		localStorage.setItem(savedFilterKey, JSON.stringify(saved));
	} catch (error) {
		return;
	}
}

function restoreFilters() {
	const saved = loadSavedFilters();
	filterIdentifiers.forEach(identifier => {
		if (saved[identifier] !== undefined) {
			document.getElementById(identifier).value = saved[identifier];
		}
	});
	if (saved.sort && saved.sort.key) sortState = saved.sort;
	if (Array.isArray(saved.expanded)) expandedIds = new Set(saved.expanded);
	if (Array.isArray(saved.collapsed)) collapsedIds = new Set(saved.collapsed);
	if (typeof saved.scroll === "number") savedScroll = saved.scroll;
}

function setup() {
	fillSourceSelect(document.getElementById("source"));
	fillSelect(document.getElementById("status"), "statuses", distinctValues("status"));
	fillSelect(document.getElementById("tag"), "projects and tags", distinctValues("tags"));
	fillSelect(document.getElementById("priority"), "priorities", distinctValues("priority"));
	fillSelect(document.getElementById("difficulty"), "difficulties", distinctValues("difficulty"));
	restoreFilters();
	let scrollTimer = null;
	window.addEventListener("scroll", () => {
		clearTimeout(scrollTimer);
		scrollTimer = setTimeout(saveFilters, 200);
	});
	if (!tabNames.includes(document.getElementById("source").value)) {
		document.getElementById("source").value = tabNames[0];
	}
	document.querySelectorAll("input, select").forEach(element => element.addEventListener("input", () => {
		saveFilters();
		render();
	}));
	document.querySelectorAll("select").forEach(element => element.addEventListener("change", () => {
		saveFilters();
		render();
	}));
	document.querySelectorAll("th.sortable").forEach(header => header.addEventListener("click", () => sortBy(header.dataset.key)));
	render();
	if (savedScroll !== null) window.scrollTo(0, savedScroll);
}

setup();
</script>
</body>
</html>
"""


def page_html(entries):
	data = json.dumps(entries, ensure_ascii=False).replace("</", "<\\/")
	return TEMPLATE.replace("__DATA__", data).replace("__REFRESH__", str(REFRESH_SECONDS))


def write_page():
	with open(OUTPUT_PATH, "w", encoding="utf-8") as file:
		file.write(page_html(collect_entries()))


def main():
	write_page()
	print("wrote " + OUTPUT_PATH)


if __name__ == "__main__":
	main()
