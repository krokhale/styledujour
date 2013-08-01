define ['backboneforms', 'external_backbone/shared/custom_editors/custom_table_editor/custom_table'], (bforms, CustomTable) ->
  SkynetExternalApp = require('external_app')
  class CustomTableEditor extends Backbone.Form.editors.Base

    tagName: "div"

    events:
      change: ->
        false

      focus: ->
        false

      blur: ->
        false


    initialize: (options) ->
      @custom_options = options
      Backbone.Form.editors.Base::initialize.call this, options

    render: ->
#      @setValue @value
      @setValue @custom_options.schema.table_options
      this


    getValue: ->
      @new_table.getData()


    setValue: (value) ->
      if value
        collection = new SkynetApp.Models.CustomItems
        for row in value
          collection.add(new SkynetApp.Models.CustomItem(row))
        @new_table = (new CustomTable({collection: collection})).render()
      else
        @new_table = (new CustomTable()).render()
      @$el.html(@new_table.el)

    focus: ->
      false

    blur: ->
      false

  CustomTableEditor