define ['marionette', "external_backbone/shared/custom_editors/custom_editor_views/custom_table_editor/custom_table_item",
        "external_backbone/shared/custom_editors/custom_editor_views/custom_table_editor/custom_table",
       "backboneforms"], (Marionette,CustomTableItem, template, bforms) ->

          class CustomTable extends Marionette.CompositeView

#            tagName: 'tbody'
            itemView: CustomTableItem

            template: template

            itemViewContainer: "#thetable"

            events:
              "click #submit-size": "submitTheSize"
#              "click #add-row": "addRow"

            initialize: ->
              SkynetExternalApp = require('external_app')

              if @collection
                @bindTo(@collection, 'add', @afterFetch)

            onRender: ->
              unless @collection
                @$("#size-wrapper").show()
                schema =
                  schema:
                    rows:
                      type: 'Select', title: 'Rows', options: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15, 16, 17, 18, 19, 20, 21, 22,23,24,25,26,27,28,29,30]
                    columns:
                      type: 'Select', title: 'Columns', options: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15, 16, 17, 18, 19, 20, 21, 22,23,24,25,26,27,28,29,30]

                @form = (new Backbone.Form(schema)).render()
                @$("#sizes").html(@form.el)

            submitTheSize: (event) ->
              event.preventDefault()
              rows = parseInt(@form.getValue().rows)
              columns = parseInt(@form.getValue().columns)
              row_numbers = [1.."#{rows}"]
              column_numbers = [1.."#{columns}"]

              tds = []
              for num in column_numbers
                tds.push {header: false,  td: ""}

              collection = new SkynetExternalApp.Models.CustomItems
              for number in row_numbers
                collection.add(new SkynetExternalApp.Models.CustomItem({tr: tds}))

              @collection = collection
              @render()

            addRow: (event) ->
              event.preventDefault()
              columns = @collection.models[0].length
              column_numbers = [1.."#{columns}"]

              tds = []
              for num in column_numbers
                tds.push {header: false,  td: ""}
              @collection.add(new SkynetExternalApp.Models.CustomItem({tr: tds}))
              @render()


            getData: ->
              json_data = []
              for key, tr_view of @.children._views
                tr_data = []
                for td_view in tr_view.views
                  tr_data.push(td_view.getData())
                json_data.push({tr: tr_data})
              json_data



          CustomTable