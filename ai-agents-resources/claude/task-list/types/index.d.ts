export type TaskStatus = 'pending' | 'in_progress' | 'done'

// The number is assigned by the plugin and never reused, so a task can be referred to by it.
export type Task = { title: string; status: TaskStatus; number: number }

declare module 'claude-code' {
  interface PluginState {
    'task-list': { tasks: Shaped<Task[]> }
  }
}
