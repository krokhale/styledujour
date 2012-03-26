Styledujour.Views.Hcit ||= {}

class Styledujour.Views.Hcit.GetPageDetailView extends Backbone.View
  template: JST["backbone/templates/hcit/get_page_detail"]

  render: ->
    $(@el).html(@template())
    return this
