define ['marionette',
        "external_backbone/shared/custom_editors/custom_auto_editor/custom_auto_fill",
        "backboneforms", 'tags'], (Marionette, template, bforms, tags) ->
          SkynetExternalApp = require('external_app')
          class CustomAutoFill extends Marionette.CompositeView

            template: template

            onRender: ->
              @$("#auto-fill").tagit({autocomplete: {delay: 0, minLength: 2, source: @options.auto_source}})

            getTags: ->
              @$("#auto-fill").tagit('assignedTags')

            setTags: (tags) ->
              for tag in tags
                @$("#auto-fill").tagit("createTag", tag);

            serializeData: ->
              @options.schema



          CustomAutoFill