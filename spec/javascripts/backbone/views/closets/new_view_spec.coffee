Styledujour.Views.Closets ||= {}

class Styledujour.Views.Closets.NewView extends Backbone.View
  template: JST["backbone/templates/closets/new"]

  events:
    "submit #new-closet": "save"

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
      success: (closet) =>
        @model = closet
        window.location.hash = "/#{@model.id}"

      error: (closet, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
