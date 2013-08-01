#define ['marionette', "external_backbone/shared/custom_editors/custom_button_editor/custom_button_template"], (Marionette, template) ->
#  SkynetExternalApp = require('external_app')
#  class CustomButtonTemplate extends Marionette.ItemView
#
#    template: template
#    className: 'panel'
#
##    serializeData: ->
##      {value: @options.value}
#
#  CustomButtonTemplate