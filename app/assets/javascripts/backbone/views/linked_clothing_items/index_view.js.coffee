Styledujour.Views.LinkedClothingItems ||= {}

class Styledujour.Views.LinkedClothingItems.IndexView extends Backbone.View
  template: JST["backbone/templates/linked_clothing_items/index"]

  initialize: () ->
    @options.linkedClothingItems.bind('reset', @addAll)

  addAll: () =>
    @options.linkedClothingItems.each(@addOne)

  addOne: (linkedClothingItem) =>
    view = new Styledujour.Views.LinkedClothingItems.LinkedClothingItemView({model : linkedClothingItem})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(linkedClothingItems: @options.linkedClothingItems.toJSON() ))
    @addAll()

    return this
