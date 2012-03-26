Styledujour.Views.LinkedClothingItems ||= {}

class Styledujour.Views.LinkedClothingItems.NewView extends Backbone.View
  template: JST["backbone/templates/linked_clothing_items/new"]

  events:
    "submit #new-linked_clothing_item": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (linked_clothing_item) =>
        @model = linked_clothing_item
        window.location.hash = "/#{@model.id}"

      error: (linked_clothing_item, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
