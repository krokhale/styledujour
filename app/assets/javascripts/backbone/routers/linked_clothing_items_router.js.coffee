class Styledujour.Routers.LinkedClothingItemsRouter extends Backbone.Router
  initialize: (options) ->
    @linkedClothingItems = new Styledujour.Collections.LinkedClothingItemsCollection()
    @linkedClothingItems.reset options.linkedClothingItems if options

  routes:
    "/new"      : "newLinkedClothingItem"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newLinkedClothingItem: ->
    @view = new Styledujour.Views.LinkedClothingItems.NewView(collection: @linkedClothingItems)
    $("#linked_clothing_items").html(@view.render().el)

  index: ->
    @view = new Styledujour.Views.LinkedClothingItems.IndexView(linkedClothingItems: @linkedClothingItems)
    $("#linked_clothing_items").html(@view.render().el)

  show: (id) ->
    linkedClothingItem = @linkedClothingItems.get(id)

    @view = new Styledujour.Views.LinkedClothingItems.ShowView(model: linkedClothingItem)
    $("#linked_clothing_items").html(@view.render().el)

  edit: (id) ->
    linkedClothingItem = @linkedClothingItems.get(id)

    @view = new Styledujour.Views.LinkedClothingItems.EditView(model: linkedClothingItem)
    $("#linked_clothing_items").html(@view.render().el)
