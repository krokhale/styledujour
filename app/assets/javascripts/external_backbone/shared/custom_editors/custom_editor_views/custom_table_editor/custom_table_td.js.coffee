define ['marionette', "external_backbone/shared/custom_editors/custom_table_editor/custom_table_td"], (Marionette, template) ->
  SkynetExternalApp = require('external_app')
  class CustomTableTd extends Marionette.ItemView

    tagName: "td"
    template: template

    onRender: ->
#      console.log @model

    getData: ->
      val = @$("#td-val").val()
      if @model.get('header')
        val = @model.get('td')
      else
        val = @$("#td-val").val()
      {header: @model.get('header'), td: val}


  CustomTableTd