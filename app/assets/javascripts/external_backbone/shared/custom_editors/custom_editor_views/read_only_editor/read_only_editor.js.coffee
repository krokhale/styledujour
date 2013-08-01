define ['backboneforms', 'external_backbone/shared/custom_editors/custom_editor_views/read_only_editor/read_only_template'], (bforms, ReadOnlyTemplate) ->
  SkynetExternalApp = require('external_app')
  class ReadOnlyEditor extends Backbone.Form.editors.Base

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
      @new_template.$el.text()


    setValue: (value) ->
#      @new_template = (new ReadOnlyTemplate({value: @custom_options.schema.options.template_value}))
      custom_item = new SkynetExternalApp.Models.CustomItem({template_value: @custom_options.model.get(@custom_options.key)})
      @new_template = (new ReadOnlyTemplate({model: custom_item}))
#      @new_template = new ReadOnlyTemplate
      @$el.html(@new_template.render().el)


    focus: ->
      false

    blur: ->
      false

  ReadOnlyEditor