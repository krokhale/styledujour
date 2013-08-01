define ['marionette', "external_backbone/shared/custom_editors/custom_table_editor/custom_table_item",
        "external_backbone/shared/custom_editors/custom_table_editor/custom_table_td"], (Marionette, template, CustomTableTd) ->
          SkynetExternalApp = require('external_app')
          class CustomTableItem extends Marionette.ItemView

            tagName: "tr"
            template: template

            onRender: ->
              @views = []
              for tr in @model.get('tr')
                model = new SkynetExternalApp.Models.CustomItem(tr)
                view = (new CustomTableTd({model: model})).render()
                $(@el).append(view.el)
                @views.push view


          CustomTableItem