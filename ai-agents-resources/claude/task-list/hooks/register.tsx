import { atom, read, update } from 'claude-code'
import type { Register } from 'claude-code'

import type { Task, TaskStatus } from '../types'

const PANE = 'task-list'
const TOOL = 'set_tasks'
const STATUSES: readonly TaskStatus[] = ['pending', 'in_progress', 'done']

const tasks = atom({ plugin: 'task-list', key: 'tasks' } as const, [], { shape: 'tasks-1' })

const marker = (status: TaskStatus): string => (status === 'done' ? '[x]' : status === 'in_progress' ? '[>]' : '[ ]')

// A title may come with a leading number ("17. Write the docs"), which is stripped: the plugin owns the numbers.
const LEADING_NUMBER = /^\d+\.\s+/

// Accept the tasks array directly, wrapped as { tasks }, or as a JSON string (some hosts stringify arguments).
const unwrapTasks = (input: unknown): unknown => {
  const parseJson = (value: unknown): unknown => {
    if (typeof value !== 'string') return value
    try { return JSON.parse(value) } catch { return undefined }
  }
  let value = parseJson(input)
  if (value && typeof value === 'object' && !Array.isArray(value) && 'tasks' in value) value = parseJson((value as { tasks: unknown }).tasks)
  return value
}

// Last resort: find the first array of task-like objects anywhere in the input (a few levels deep).
const findTaskArray = (value: unknown, depth = 0): unknown[] | undefined => {
  if (depth > 3 || value === null || typeof value !== 'object') return undefined
  if (Array.isArray(value)) {
    if (value.some(item => item && typeof item === 'object' && 'title' in item)) return value
    return undefined
  }
  for (const child of Object.values(value)) {
    const found = findTaskArray(child, depth + 1)
    if (found) return found
  }
  return undefined
}

const parseTasks = (input: unknown): Omit<Task, 'number'>[] | string => {
  const list = unwrapTasks(input) ?? findTaskArray(input)
  if (!Array.isArray(list)) {
    const shape = input && typeof input === 'object' ? Object.keys(input).join(', ') : typeof input
    return `tasks must be an array. Received: ${shape || 'nothing'}.`
  }
  const parsed: Omit<Task, 'number'>[] = []
  for (const item of list) {
    const { title, status } = (item ?? {}) as { title?: unknown; status?: unknown }
    if (typeof title !== 'string' || title.trim().replace(LEADING_NUMBER, '') === '') return 'each task needs a non empty title.'
    if (!STATUSES.includes(status as TaskStatus)) return `status must be one of ${STATUSES.join(', ')}.`
    parsed.push({ title: title.trim().replace(LEADING_NUMBER, ''), status: status as TaskStatus })
  }
  return parsed
}

// Numbers are never reused: a task keeps the number it had under the same title, a new task gets the next free one.
// Tasks saved before numbers existed get one here, in order.
const numbered = (previous: Task[], incoming: Omit<Task, 'number'>[]): Task[] => {
  const numberByTitle = new Map(previous.filter(task => task.number !== undefined).map(task => [task.title, task.number]))
  let next = Math.max(0, ...previous.map(task => task.number ?? 0)) + 1
  return incoming.map(task => {
    const number = numberByTitle.get(task.title) ?? next++
    return { ...task, number }
  })
}

const withNumbers = (list: Task[]): Task[] => numbered(
  list.filter(task => task.number !== undefined),
  list.map(task => ({ ...task, title: task.title.replace(LEADING_NUMBER, '') })),
)

export const register: Register = on => {
  on('session.start', async ($, e, next) => {
    await $.tool.register({
      name: TOOL,
      description: 'Replace the list of tasks shown to the user in the "Tasks" side pane. Send the whole list each time, in order, with the status of each task (pending, in_progress or done). Call it when the user gives a plan and each time a task starts or ends. The plugin numbers the tasks: keep the exact same title for a task so it keeps its number, and do not put numbers in titles. The numbers are returned in the result and let the user refer to a task by its number.',
      isDeferred: false,
      inputSchema: {
        type: 'object',
        properties: {
          tasks: {
            type: 'array',
            items: {
              type: 'object',
              properties: { title: { type: 'string' }, status: { type: 'string', enum: [...STATUSES] } },
              required: ['title', 'status'],
            },
          },
        },
        required: ['tasks'],
      },
    })
    await $.command.register({ name: 'tasks', description: 'Show the task list pane' })
    if ((await read($, tasks)).length > 0) void $.ui.open({ id: PANE, title: 'Tasks' })

    return next(e)
  })

  on('command.run', { command: 'tasks' }, async $ => {
    await $.ui.open({ id: PANE, title: 'Tasks' })

    return { text: 'Task list pane opened.' }
  })

  on('tool.call', { tool: `mcp__task-list__${TOOL}` }, async ($, e) => {
    const parsed = parseTasks(e.input ?? e)
    if (typeof parsed === 'string') return { deny: parsed }
    const previous = withNumbers(await read($, tasks))
    const updated = numbered(previous, parsed)
    await update($, tasks, () => updated)
    void $.ui.open({ id: PANE, title: 'Tasks' })
    const remaining = updated.filter(task => task.status !== 'done').length
    const numbers = updated.map(task => `#${task.number} ${task.title} (${task.status})`).join('; ')

    return { result: `Task list updated: ${remaining} remaining of ${updated.length}. ${numbers}` }
  })

  on('ui.render', { component: 'Pane', requestId: PANE }, async ($, e) => {
    const { Box, Text } = $.ui.resolve(e)
    const list = withNumbers(await read($, tasks))
    const remaining = list.filter(task => task.status !== 'done')
    const done = list.filter(task => task.status === 'done')

    return (
      <Box flexDirection="column">
        {list.length === 0 && <Text dimColor>No tasks yet.</Text>}
        {list.length > 0 && <Text bold>Remaining: {remaining.length} / {list.length}</Text>}
        {remaining.map(task => (
          <Text bold={task.status === 'in_progress'} color={task.status === 'in_progress' ? 'warning' : undefined}>
            {marker(task.status)} #{task.number} {task.title}
          </Text>
        ))}
        {done.map(task => (
          <Text dimColor strikethrough>
            {marker(task.status)} #{task.number} {task.title}
          </Text>
        ))}
      </Box>
    )
  })
}
