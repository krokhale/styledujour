Styledujour.Views.LinkedClothingItems ||= {}

class Styledujour.Views.LinkedClothingItems.LinkedClothingItemView extends Backbone.View
  template: JST["backbone/templates/linked_clothing_items/linked_clothing_item"]

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
