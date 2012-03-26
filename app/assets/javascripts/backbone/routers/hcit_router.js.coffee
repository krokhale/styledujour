class Styledujour.Routers.HcitRouter extends Backbone.Router
  initialize: (options) ->

  routes:
    "/get_page_detail": "get_page_detail"
    ".*"        : "index"
    
  get_page_detail: ->
    @view = new Styledujour.Views.Hcit.GetPageDetailView()
    $("#hcit").html(@view.render().el)

  index: ->
    @view = new Styledujour.Views.Hcit.GetIndexView()
    $("#hcit").html(@view.render().el)
