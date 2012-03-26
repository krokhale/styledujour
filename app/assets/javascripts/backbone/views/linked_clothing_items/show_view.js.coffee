Styledujour.Views.LinkedClothingItems ||= {}

class Styledujour.Views.LinkedClothingItems.ShowView extends Backbone.View
  template: JST["backbone/templates/linked_clothing_items/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
