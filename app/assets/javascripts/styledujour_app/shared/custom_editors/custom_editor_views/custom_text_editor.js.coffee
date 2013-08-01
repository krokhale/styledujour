define ['backboneforms'], (bforms) ->
  SkynetExternalApp = require('external_app')
  class CustomTextEditor extends Backbone.Form.editors.Base

    tagName: "textarea"

    events:
      change: ->
        false

      focus: ->
        false

      blur: ->
        false


    initialize: (options) ->
      Backbone.Form.editors.Base::initialize.call this, options

    render: ->
      console.log @$el.attr('id')
      @setValue @value
      this

    getValue: ->
#      SkynetExternalApp = require('external_app')
      val = SkynetExternalApp.currentEditor.instanceById(@$el.attr('id')).getContent()
      if val == '<br>'
        ''
      else
        val

    setValue: (value) ->
      setTimeout ( =>
        SkynetExternalApp.currentEditor.panelInstance(@$el.attr('id'))
        SkynetExternalApp.currentEditor.instanceById(@$el.attr('id')).setContent(value)
      ), 2000


    focus: ->
      false

    blur: ->
      false

  CustomTextEditor