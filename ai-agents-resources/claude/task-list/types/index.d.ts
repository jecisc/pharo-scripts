export type TaskStatus = 'pending' | 'in_progress' | 'done'

// The number is assigned by the plugin and never reused, so a task can be referred to by it.
export type Task = { title: string; status: TaskStatus; number: number }

// An entry of the backlog or agent findings files. Parent is the ID of the meta task it belongs to, if any.
export type BacklogItem = { id: string; title: string; status: string; parent: string }

declare module 'claude-code' {
  interface PluginState {
    'task-list': {
      tasks: Shaped<Task[]>
      backlogItems: Shaped<BacklogItem[]>
      findingItems: Shaped<BacklogItem[]>
    }
  }
}
