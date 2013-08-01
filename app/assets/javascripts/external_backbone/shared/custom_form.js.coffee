define ['marionette', "external_backbone/shared/custom_form_template",'backboneforms',
        "external_backbone/shared/templates/date_template",
        "external_backbone/shared/templates/datetime_template",
        "external_backbone/shared/templates/field_template",
        "external_backbone/shared/templates/fieldset_template",
        "external_backbone/shared/templates/form_template",
        "external_backbone/shared/templates/list_item_template",
        "external_backbone/shared/templates/list_modal_template",
        "external_backbone/shared/templates/list_template",
        "external_backbone/shared/templates/nested_field_template",

        "external_backbone/shared/custom_editors/custom_editor_views/custom_text_editor",
        "external_backbone/shared/custom_editors/custom_editor_views/custom_upload_editor",
#        "backbone/views/shared/master_edit/custom_editors/custom_upload_editor",
#        "backbone/views/shared/master_edit/custom_editors/custom_auto_editor/custom_auto_editor",
#        "backbone/views/shared/master_edit/custom_editors/custom_table_editor/custom_table_editor",
#        "backbone/views/shared/master_edit/custom_editors/read_only_editor/read_only_editor",
#        "backbone/views/shared/master_edit/custom_editors/custom_button_editor/custom_button_editor",

        'backboneformsmodal','backboneformslist'
        ], (Marionette, template, bform, dateTemplate,
            dateTimeTemplate, fieldTemplate, fieldsetTemplate,
            formTemplate, listItemTemplate, listModalTemplate,
            listTemplate, nestedFieldTemplate, CustomTextEditor , CustomUploadEditor,Modal,list) ->

            SkynetExternalApp = require('external_app')
            class CustomForm extends Marionette.Layout

              template: template

              regions:
                theform: '#customform'

              events:
                "click #submit-stuff": "submitForm"
                "click #close": "closeForm"
#                "click #print-form": "printForm"
                'click .common-link': 'doNothing'

              doNothing: (event) ->
                event.preventDefault()


              initialize: ->
#                SkynetExternalApp.vent.on("SkynetApp:CustomForm:Success", @showSuccess)
#                SkynetExternalApp.vent.on("SkynetApp:CustomForm:Error", @showError)
#                SkynetExternalApp.vent.on("SkynetApp:CustomForm:PDFetch", @afterPdfFetch)
#                SkynetExternalApp.vent.on("SkynetApp:CustomForm:Spinner", @showSpinner)


              onRender: ->
                templates = @getTemplates()
                Backbone.Form.setTemplates(templates, {error: 'error'})
#                if @options.form
#                  schema = @formatSchema(@options.form.get('fields_schema').schema)
#                  @renderForm(schema)
#                else
                @model.custom_model_schema.schema = @formatSchema(@model.custom_model_schema.schema)
                @renderForm(@model.custom_model_schema)
                @$("#submit-stuff a").text(@options.submit_text) if @options.submit_text


              renderForm: (schema) =>
                @form = (new Backbone.Form(schema))
                @theform.show(@form)
                SkynetExternalApp.vent.trigger("formRendered", @form, @options.form_identifier)


              formatSchema: (schema) ->
                for key, value of schema
                  if value.type == 'Table'
                    value.type = CustomTableEditor
                  else if value.type == 'CustomUploadEditor'
                    value.type = CustomUploadEditor
                  else if value.type == 'CustomTextEditor'
                    console.log "was here"
                    value.type = CustomTextEditor
                  else if value.type == 'CustomAutoEditor'
                    value.type = CustomAutoEditor
                  else if value.type == 'CustomButton'
                    value.type = CustomButtonEditor
                  else if value.type == 'ReadOnly'
                    value.type = ReadOnlyEditor
                schema


              getTemplates: ->
                templates =
                  form: formTemplate()
                  fieldset: fieldsetTemplate()
                  field: fieldTemplate()
                  nestedField: nestedFieldTemplate()
                  list: listTemplate()
                  listItem: listItemTemplate()
                  date: dateTemplate()
                  dateTime: dateTimeTemplate()
                  'list.Modal': listModalTemplate()
                templates

              submitForm: ->
                if @form.commit() == undefined
                  #this is triggered when its all validated, so listen for it in your view.
                  SkynetExternalApp.vent.trigger("formSubmitted", @form, @options.form_identifier)

              closeForm: ->
                $("#custom-form").slideUp('fast')
                @close()
                SkynetExternalApp.vent.trigger("formClosed", @options.form_identifier)

              showSuccess: (identifier) =>
                if @options.form_identifier == identifier
                  @$('#activity-spinner').hide()
                  @$('#error').hide()
                  @$('#success').show().effect('highlight', =>
                  )

              showError: (identifier) =>
                @$('#activity-spinner').hide()
                if @options.form_identifier == identifier
                  @$('#error').show().effect('highlight')
                  @$('#success').hide()

              showSpinner: (identifier) =>
                if @options.form_identifier == identifier
                  @$('#activity-spinner').show()


            CustomForm


#  CustomTextEditor, CustomUploadEditor, CustomAutoEditor, CustomTableEditor, ReadOnlyEditor, CustomButtonEditor,