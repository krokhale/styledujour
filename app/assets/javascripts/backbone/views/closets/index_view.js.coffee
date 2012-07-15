Styledujour.Views.Closets ||= {}

class Styledujour.Views.Closets.IndexView extends Backbone.View
  template: JST["backbone/templates/closets/index"]

  initialize: () ->
    @options.closets.bind('reset', @addAll)

  addAll: () =>
    @options.closets.each(@addOne)

  addOne: (closet) =>
    view = new Styledujour.Views.Closets.ClosetView({model : closet})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(closets: @options.closets.toJSON() ))
    @addAll()

    return this
