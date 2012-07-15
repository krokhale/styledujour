Styledujour.Views.Closets ||= {}

class Styledujour.Views.Closets.EditView extends Backbone.View
  template : JST["backbone/templates/closets/edit"]

  events :
    "submit #edit-closet" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (closet) =>
        @model = closet
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
