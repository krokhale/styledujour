#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Styledujour =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  
_.extend Backbone.View::,
  parse: (objName) ->
    self = this
    _recurse_form = (object, objName) ->
      _.each object, (v, k) ->
        if v instanceof Object
          object[k] = _recurse_form(v, objName + "[" + k + "_attributes]")
        else
          object[k] = self.$("[name=\"" + objName + "[" + k + "]\"]").val()

      object

    @model.attributes = _recurse_form(@model.attributes, objName)

  populate: (objName) ->
    self = this
    _recurse_obj = (object, objName) ->
      _.each object, (v, k) ->
        if v instanceof Object
          _recurse_obj v, objName + "[" + k + "_attributes]"
        else self.$("[name=\"" + objName + "[" + k + "]\"]").val v  if _.isString(v)

    _recurse_obj @model.attributes, objName