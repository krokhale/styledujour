class Styledujour.Models.Task extends Backbone.Model
  paramRoot: 'task'

  defaults:
    title: null
    description: null
    due_date: null
    completion_date: null
    is_complete: null
    user_id: null
    client_id: null

class Styledujour.Collections.TasksCollection extends Backbone.Collection
  model: Styledujour.Models.Task
  url: '/tasks'
