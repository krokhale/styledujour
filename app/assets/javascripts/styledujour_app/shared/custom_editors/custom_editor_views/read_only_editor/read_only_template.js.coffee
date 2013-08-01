define ['marionette', "external_backbone/shared/custom_editors/read_only_editor/read_only_template"], (Marionette, template) ->
  SkynetExternalApp = require('external_app')
  class ReadOnlyTemplate extends Marionette.ItemView

    template: template
    className: 'panel'

#    serializeData: ->
#      {value: @options.value}

  ReadOnlyTemplate