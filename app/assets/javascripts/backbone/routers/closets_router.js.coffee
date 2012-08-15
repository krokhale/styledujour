class Styledujour.Routers.ClosetsRouter extends Backbone.Router
  initialize: (options) ->
    @closets = new Styledujour.Collections.ClosetsCollection()
    @closets.reset options.closets

  routes:
    "new"                : "newCloset"
    "index"              : "index"
    ":id/edit"           : "edit"
    ":id"                : "show"
    ".*"                  : "index"
    ":id/outfits"        : "outfitIndex"
    ":id/outfits/new"    : "newOutfit"
    ":id/outfits/:outfit" : "showOutfit"
    ":id/clothing_items" : "clothingItemIndex"

  newCloset: ->
    @view = new Styledujour.Views.Closets.NewView(collection: @closets)
    $("#closets").html(@view.render().el)

  index: ->
    @view = new Styledujour.Views.Closets.IndexView(closets: @closets)
    $("#closets").html(@view.render().el)

  show: (id) ->
    closet = @closets.get(id)

    @view = new Styledujour.Views.Closets.ShowView(model: closet)
    $("#closets").html(@view.render().el)

  edit: (id) ->
    closet = @closets.get(id)

    @view = new Styledujour.Views.Closets.EditView(model: closet)
    $("#closets").html(@view.render().el)

  outfitIndex: (id) ->
    closet = @closets.get(id)
    closet.outfits.fetch()

    @view = new Styledujour.Views.Outfits.IndexView(outfits: closet.outfits, closet_id: id)
    $("#outfits").html(@view.render().el)

  newOutfit: (id) ->
    closet = @closets.get(id)
    closet.clothing_items = new Styledujour.Collections.ClothingItemsCollection({closet_id: id})

    closet.clothing_items.fetch({
      success: =>
        @view = new Styledujour.Views.Outfits.NewView(collection: closet.outfits, closet_id: id, clothing_items: closet.clothing_items)
        $("#outfits").html(@view.render().el)
      })

  showOutfit: (id, outfit) ->
    closet = @closets.get(id)
    outfit = closet.outfits.get(outfit)

    @view = new Styledujour.Views.Outfits.ShowView(model: outfit)
    $("#outfits").html(@view.render().el)

  clothingItemIndex: (id) ->
    closet = @closets.get(id)
    closet.clothing_items = new Styledujour.Collections.ClothingItemsCollection({closet_id: id})

    closet.clothing_items.fetch({
      success: =>
        @view = new Styledujour.Views.ClothingItems.IndexView(clothing_items: closet.clothing_items, closet_id: id)
        $("#clothing_items").html(@view.render().el)
      })
    
    