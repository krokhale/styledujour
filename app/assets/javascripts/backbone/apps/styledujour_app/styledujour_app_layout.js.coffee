define ['marionette', "backbone/templates/apps/admissions_app/admissions_app_layout",
  'backbone/apps/admissions_app/menu', 'backbone/apps/admissions_app/models',
  "backbone/views/shared/table/rows_collection",
  "backbone/apps/shared/custom_form_design/custom_form_design_layout",
  "backbone/apps/shared/simple_form/simple_form"],(Marionette, template, Menu, Models, RowsCollection,CustomFormDesignLayout, SimpleForm) ->
  SkynetApp = require('app')
  class AdmissionsAppLayout extends Marionette.Layout

    template: template

    regions:
      menu: '#menu'
      newcustomform: "#design-form"
      externalSettings: "#external-settings"

    initialize: ->
      SkynetApp.vent.on('showRows', @showRows)
      SkynetApp.CurrentApp = SkynetApp.currentResource
      SkynetApp.CurrentApp.Models = Models
      SkynetApp.CurrentApp.fetch({success: @fetchedTheApp})

    fetchedTheApp: (app) =>
      SkynetApp.vent.trigger('appFetched')

      form = SkynetApp.CurrentApp._skynet_forms.where({form_type: 'External App Settings'})[0]

      console.log form.get('fields_schema').schema

      for scheme in form.get('fields_schema').schema
        scheme.options = SkynetApp.CurrentApp._skynet_forms if scheme.type=='Select'
        new_schema = $.extend({}, new_schema, scheme)


      console.log new_schema

#      test = new SkynetApp.Models.Teachers

#      new_schema.select_a_form_for_contact_information_block.options = SkynetApp.CurrentApp._skynet_forms
#      new_schema.select_a_form_for_institute_and_course_preferences_block.options = SkynetApp.CurrentApp._skynet_forms
#      new_schema.select_a_form_for_personal_information_block.options = SkynetApp.CurrentApp._skynet_forms
#      new_schema.select_a_form_for_required_documents_block.options = SkynetApp.CurrentApp._skynet_forms
#      new_schema.select_a_form_for_educational_background_block.options = SkynetApp.CurrentApp._skynet_forms

#      @newcustomform.show(new CustomFormDesignLayout({model: SkynetApp.CurrentApp ,master_form: SkynetApp.CurrentApp._skynet_forms.models[0], heading_filler: "Design Admission Forms"}))

      custom_model_schema =
        model: SkynetApp.CurrentApp
        fieldsets: [{legend: "<h4 class='red' style='font-weight: bold'>#{form.get('form_type')}</h4>", fields: form.get('field_params')}]
        schema: new_schema

      @externalSettings.show(new SimpleForm({custom_model_schema: custom_model_schema}))


    showRows: (users) =>
      new RowsCollection({el: @$('#the-table'), collection: users}).render()
#      view = new RowsCollection({collection: users}).render({el: @$('#the-table')}).el
#      @$('#the-table').append(view.render.el)


    onRender: ->
      @menu.show(new Menu)
      SkynetApp.initTabs(@$('.tabs'))
#      @newcustomform.show(new CustomFormDesignLayout({model: @model, master_form: @options.master_form, heading_filler: @options.heading_filler}))



#      SkynetApp.currentResource.initialize()

#      @editlayout.show(new EditLayout({model: SkynetApp.currentResource,
#        edit_model: SkynetApp.Models.Student,
#        system_forms_hash: [{form: SkynetApp.currentResource._skynet_forms.where({form_type: 'SkynetApp Student Form'})[0], model: SkynetApp.Models.Student}],
#        new_form_legend: "New Student Admission", edit_collection: SkynetApp.Models.Students,
#        custom_identifier: {students_app: true}, heading_filler: 'Student', grid_ups: 'tiles five_up', show_delete: true,
#        master_form: SkynetApp.currentResource._skynet_forms.where({form_type: 'SkynetApp Student Form'})[0]}))


  AdmissionsAppLayout
