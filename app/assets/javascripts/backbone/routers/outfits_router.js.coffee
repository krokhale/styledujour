class Styledujour.Routers.OutfitsRouter extends Backbone.Router
  initialize: (options) ->
    @outfits = new Styledujour.Collections.OutfitsCollection()
    @outfits.reset options.outfits

  routes:
    "/new"      : "newOutfit"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newOutfit: ->
    @view = new Styledujour.Views.Outfits.NewView(collection: @outfits)
    $("#outfits").html(@view.render().el)

  index: ->
    @view = new Styledujour.Views.Outfits.IndexView(outfits: @outfits)
    $("#outfits").html(@view.render().el)

  show: (id) ->
    outfit = @outfits.get(id)

    @view = new Styledujour.Views.Outfits.ShowView(model: outfit)
    $("#outfits").html(@view.render().el)

  edit: (id) ->
    outfit = @outfits.get(id)

    @view = new Styledujour.Views.Outfits.EditView(model: outfit)
    $("#outfits").html(@view.render().el)
