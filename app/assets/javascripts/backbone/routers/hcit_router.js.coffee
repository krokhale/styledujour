class Styledujour.Routers.HcitRouter extends Backbone.Router
  initialize: (options) ->
    @clothing_items = new Styledujour.Collections.ClothingItemsCollection()
    @clothing_items.reset options.clothing_items

  routes:
    "new"      : "newClothingItem"
    "index"    : "index"
    "browse"   : "browse"
    "clothing_items/:id"      : "show"
    ":id/edit" : "edit"
    ".*"        : "index"

  notFound: (path) ->
    alert('Unable to find ' + path)

  newClothingItem: ->
    @view = new Styledujour.Views.ClothingItem.NewView(collection: @clothing_items)
    $("#hcit").html(@view.render().el)

  index: ->
    @view = new Styledujour.Views.Hcit.IndexView()
    $("#hcit").html(@view.render().el)
  
  browse: ->
    #@clothing_items.url = "/hcit/browse.json"
    temp = @view
    @clothing_items.fetch({
      success: =>
        temp = new Styledujour.Views.Hcit.BrowseView(clothing_items: @clothing_items)
        $("#hcit").html(temp.render().el)
      })


    


  show: (id) ->
    clothing_item = @clothing_items.get(id)
    if (clothing_item == undefined)
      clothing_item = new Styledujour.Models.ClothingItem({id: id})
      clothing_item.fetch({
      success: =>
        @view = new Styledujour.Views.ClothingItems.ShowView(model: clothing_item)
        $("#hcit").html(@view.render().el)
      })
    else
      @view = new Styledujour.Views.ClothingItems.ShowView(model: clothing_item)
      $("#hcit").html(@view.render().el)

  edit: (id) ->
    clothing_item = @clothing_items.get(id)

    @view = new Styledujour.Views.ClothingItems.EditView(model: clothing_item)
    $("#hcit").html(@view.render().el)
