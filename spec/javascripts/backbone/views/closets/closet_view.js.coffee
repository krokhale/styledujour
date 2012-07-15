Styledujour.Views.Closets ||= {}

class Styledujour.Views.Closets.ClosetView extends Backbone.View
  template: JST["backbone/templates/closets/closet"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
