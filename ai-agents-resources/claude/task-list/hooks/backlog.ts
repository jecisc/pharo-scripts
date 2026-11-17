import type { BacklogItem } from '../types'

const HEADING = /^## ((?:U|A)-\d+) — (.+)$/
const FIELD = /^- \*\*([A-Za-z ]+):\*\* ?(.*)$/
const NO_PARENT = 'none'

/** Reads the `## U-nnn` or `## A-nnn` entries of a backlog or findings file, with their Status and Parent fields. */
export function parseEntries(markdown: string): BacklogItem[] {
  const items: BacklogItem[] = []

  for (const rawLine of markdown.split('\n')) {
    const line = rawLine.trimEnd()
    const heading = HEADING.exec(line)
    if (heading) {
      items.push({ id: heading[1], title: heading[2], status: 'unknown', parent: '' })
      continue
    }

    const current = items[items.length - 1] as BacklogItem | undefined
    const field = FIELD.exec(line)
    if (current === undefined || field === null) {
      continue
    }

    if (field[1] === 'Status') current.status = field[2].trim()
    if (field[1] === 'Parent' && field[2].trim() !== NO_PARENT) current.parent = field[2].trim()
  }

  return items.sort((first, second) => numberOf(first.id) - numberOf(second.id))
}

/** Lists the items with each subtask right after its meta task, indented by one level. Answers [item, depth] pairs. */
export function outline(items: BacklogItem[]): [BacklogItem, number][] {
  const identifiers = new Set(items.map(item => item.id))
  const rows: [BacklogItem, number][] = []
  const addWithChildren = (item: BacklogItem, depth: number) => {
    rows.push([item, depth])
    items.filter(child => child.parent === item.id).forEach(child => addWithChildren(child, depth + 1))
  }
  items.filter(item => item.parent === '' || !identifiers.has(item.parent)).forEach(item => addWithChildren(item, 0))

  return rows
}

const numberOf = (id: string): number => Number(id.slice(id.indexOf('-') + 1))
