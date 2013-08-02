require ["jquery", "underscore", "backbone", "marionette", "supermodel", "external_app"], ($, _, Backbone, Marionette, Supermodel, StyleDujourApp) ->
#  Marionette.Renderer.render = (template, data) ->
#    throw "Template '" + template + "' not found!" unless JST[template]
#    JST[template](data)
#  console.log bar
#  console.log $

#  Marionette.Region.prototype.open = (view) ->
#    this.$el.hide()
#    this.$el.html(view.el)
#    this.$el.slideDown("fast")

  Marionette.TemplateCache::loadTemplate = (templateId) ->
    # Marionette expects "templateId" to be the ID of a DOM element.
    # But with RequireJS, templateId is actually the full text of the template.
    template = templateId

    # Make sure we have a template before trying to compile it
    if not template or template.length is 0
      msg = "Could not find template: '" + templateId + "'"
      err = new Error(msg)
      err.name = "NoTemplateError"
      throw err
    template


  $ ->
    $("#demo").hide()
    StyleDujourApp.setupApp()


