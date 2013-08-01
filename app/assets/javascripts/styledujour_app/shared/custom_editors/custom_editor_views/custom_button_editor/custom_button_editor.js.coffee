#define ['backboneforms', 'external_backbone/shared/custom_editors/custom_button_editor/custom_button_template'], (bforms, CustomButtonTemplate) ->
#  SkynetExternalApp = require('external_app')
#  class CustomButtonEditor extends Backbone.Form.editors.Base
#
#    tagName: "div"
#
#    events:
#      change: ->
#        false
#
#      focus: ->
#        false
#
#      blur: ->
#        false
#
#
#    initialize: (options) ->
#      @custom_options = options
#      console.log options
#      @custom_model = options.model
#      Backbone.Form.editors.Base::initialize.call this, options
#
#    render: ->
#      @setValue @value
#      this
#
#    getValue: ->
#      @new_template.$el.text()
#
#
#    setValue: (value) ->
##      @new_template = (new CustomButtonTemplate({value: @custom_options.schema.options.template_value}))
#      @new_template = (new CustomButtonTemplate({value: ''}))
#      @$el.html(@new_template.render().el)
#
#
#    focus: ->
#      false
#
#    blur: ->
#      false
#
#  CustomButtonEditor