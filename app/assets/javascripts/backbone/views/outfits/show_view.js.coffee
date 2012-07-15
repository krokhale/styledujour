Styledujour.Views.Outfits ||= {}

class Styledujour.Views.Outfits.ShowView extends Backbone.View
  template: JST["backbone/templates/outfits/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
