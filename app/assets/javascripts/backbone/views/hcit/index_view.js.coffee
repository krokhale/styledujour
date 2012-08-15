Styledujour.Views.Hcit ||= {}

class Styledujour.Views.Hcit.IndexView extends Backbone.View
  template: JST["backbone/templates/hcit/index"]

  render: ->
    window.location.hash = "/browse"
    return this