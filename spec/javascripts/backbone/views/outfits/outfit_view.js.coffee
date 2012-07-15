Styledujour.Views.Outfits ||= {}

class Styledujour.Views.Outfits.OutfitView extends Backbone.View
  template: JST["backbone/templates/outfits/outfit"]

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
