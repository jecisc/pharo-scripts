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
<link rel="icon" type="image/png" href="data:image/png;base64,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">
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
const statusColors = { open: "#3b7fd1", "in-progress": "#d69a0b", "waiting-review": "#8a58d6", done: "#2e9e4f", wontfix: "#8a8a85" };
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
