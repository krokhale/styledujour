Styledujour.Views.Outfits ||= {}

class Styledujour.Views.Outfits.IndexView extends Backbone.View
  template: JST["backbone/templates/outfits/index"]

  initialize: () ->
    @options.outfits.bind('reset', @addAll)

  addAll: () =>
    @options.outfits.each(@addOne)

  addOne: (outfit) =>
    view = new Styledujour.Views.Outfits.OutfitView({model : outfit})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(outfits: @options.outfits.toJSON() ))
    @addAll()

    return this
