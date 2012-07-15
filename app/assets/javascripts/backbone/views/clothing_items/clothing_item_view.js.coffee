Styledujour.Views.ClothingItems ||= {}

class Styledujour.Views.ClothingItems.ClothingItemView extends Backbone.View
  template: JST["backbone/templates/clothing_items/clothing_item"]

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
