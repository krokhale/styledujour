define ['backboneforms',"tags", 'external_backbone/shared/custom_editors/custom_editor_views/custom_auto_editor/custom_auto_fill'], (bforms, tags, CustomAutoFill) ->
  SkynetExternalApp = require('external_app')
  class CustomAutoEditor extends Backbone.Form.editors.Base

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
      @custom_model = options.model
      Backbone.Form.editors.Base::initialize.call this, options

    render: ->
      @setValue @value
      this

    getValue: ->
      if @new_auto.getTags().length == 0
        ""
      else
        @new_auto.getTags()


    setValue: (value) ->
      @new_auto = (new CustomAutoFill({auto_source: @custom_options.schema.options.auto_source, schema: @custom_options.schema}))
      @$el.html(@new_auto.render().el)
      if value
        tags = value.split(',')
        @new_auto.setTags(tags)

    focus: ->
      false

    blur: ->
      false

  CustomAutoEditor