define ['backboneforms',"external_backbone/shared/file_uploader"], (bforms, FileUploader) ->
  SkynetExternalApp = require('external_app')
  class CustomUploadEditor extends Backbone.Form.editors.Base

    tagName: "div"

    events:
      change: ->
        false

      focus: ->
        false

      blur: ->
        false


    initialize: (options) ->
      SkynetExternalApp.vent.on "SkynetExternalApp:FileUploader:upload_complete", @uploadComplete
      @custom_model = options.model
      @custom_options = options
      Backbone.Form.editors.Base::initialize.call this, options

    render: ->
      @setValue @value

      if @custom_model.get('attachments_blob')
        file = _.pluck(@custom_model.get('attachments_blob'), @custom_options.key)[0]
      if file
        if file.file_content_type == 'image'
          @$el.append("<div class='custom-image twelve columns row' style='margin-top: 3%'><a class='row twelve columns' href=#{file.url} target='_blank'>Current File</a><img class='six' style='width:241px;height:151px; margin-top:2%' src=#{file.url}></img></div>").show()

#      if @custom_model.get('attachments_blob')
#        url = @custom_model.get('attachments_blob')[@custom_options.key]
#      if url
#        @$el.append("<div class='custom-image twelve columns row' style='margin-top: 3%'><a class='row twelve columns' href=#{url} target='_blank'>Current File</a><img class='six' style='width:241px;height:151px; margin-top:2%' src=#{url}></img></div>").show()
      this

    getValue: ->
      @current_data

    setValue: (value) ->
      params = $.extend({}, {el: @$el}, @custom_options.schema.options.attachment_end_points)
      @fileUploader = new FileUploader(params)
      @fileUploader.render()

    uploadComplete: (data) =>
      @current_data = data
      $(".custom-image").remove()
      @$el.after("<div class='custom-image twelve columns row' style='margin-top: 3%'><a class='row twelve columns' href=#{data.url} target='_blank'>Current File</a><img class='six' style='width:241px;height:151px;margin-top:2%' src=#{data.url}></img></div>")
      @fileUploader.render()

    focus: ->
      false

    blur: ->
      false

  CustomUploadEditor