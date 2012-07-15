Styledujour.Views.Hcit ||= {}

class Styledujour.Views.Hcit.BrowseView extends Backbone.View
  template: JST["backbone/templates/clothing_items/list"]

  events:
    "click #nextResultPage" : "nextResultPage",
    "click #previousResultPage" : "previousResultPage"

  initialize: () ->
    @options.clothing_items.bind('reset', @addAll)
    @options.clothing_items.on('reset', this.render, this)
    @options.clothing_items.on('change', this.render, this)
    $(@el).appendTo('#pagination')

  addAll: () =>
    @options.clothing_items.each(@addOne)

  addOne: (clothing_item) =>
    view = new Styledujour.Views.Hcit.ClothingItemView({model : clothing_item})
    @$("ul").append(view.render().el)

  nextResultPage: (e) ->
    e.preventDefault()
    @options.clothing_items.requestNextPage()

  previousResultPage: (e) ->
    e.preventDefault()
    @options.clothing_items.requestPreviousPage()

  render: =>
    $(@el).html(@template(clothing_items: @options.clothing_items.models, pagination: @options.clothing_items.pagination ))
    @addAll()


    return this
