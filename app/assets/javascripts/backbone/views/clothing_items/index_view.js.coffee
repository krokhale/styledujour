Styledujour.Views.ClothingItems ||= {}

class Styledujour.Views.ClothingItems.IndexView extends Backbone.View
  template: JST["backbone/templates/clothing_items/index"]

  initialize: () ->
    @options.clothing_items.bind('reset', @addAll)

  addAll: () =>
    outfit_canvas.loadSide(@options.clothing_items.toJSON())
    @options.clothing_items.each(@addOne)

  addOne: (clothing_item) =>
    #view = new Styledujour.Views.ClothingItems.ClothingItemView({model : clothing_item})
    #@$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(clothing_items: @options.clothing_items.toJSON(), closet_id: @options.closet_id ))
    @addAll()


    return this
