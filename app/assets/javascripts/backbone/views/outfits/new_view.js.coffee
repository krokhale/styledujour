Styledujour.Views.Outfits ||= {}

class Styledujour.Views.Outfits.NewView extends Backbone.View
  template: JST["backbone/templates/outfits/new"]

  events:
    "submit #new-outfit": "save"

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
      success: (outfit) =>
        @model = outfit
        window.location.hash = "/#{@model.id}"

      error: (outfit, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("#new-outfit").backboneLink(@model)

    return this
