Styledujour.Views.LinkedClothingItems ||= {}

class Styledujour.Views.LinkedClothingItems.EditView extends Backbone.View
  template : JST["backbone/templates/linked_clothing_items/edit"]

  events :
    "submit #edit-linked_clothing_item" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (linked_clothing_item) =>
        @model = linked_clothing_item
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
