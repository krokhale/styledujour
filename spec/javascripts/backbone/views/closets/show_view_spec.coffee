Styledujour.Views.Closets ||= {}

class Styledujour.Views.Closets.ShowView extends Backbone.View
  template: JST["backbone/templates/closets/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
