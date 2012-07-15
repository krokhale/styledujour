Styledujour.Views.Outfits ||= {}

class Styledujour.Views.Outfits.EditView extends Backbone.View
  template : JST["backbone/templates/outfits/edit"]

  events :
    "submit #edit-outfit" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (outfit) =>
        @model = outfit
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
