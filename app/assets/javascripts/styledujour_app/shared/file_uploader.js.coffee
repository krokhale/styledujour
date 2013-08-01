define ["backbone/initializers/uploader", "external_backbone/shared/file_uploader_template"], ($, template) ->
  SkynetExternalApp = require('external_app')
  class FileUploader extends Marionette.ItemView
    template: template

#    initialize: ->
#      SkynetApp.vent.on("SkynetApp:FileUploader:reset_uploader", @resetUploader)

    events:
      'click .upload': 'showUploadInput'

    onRender: ->
      @$("#fileupload").attr({'data-url': @options.url})
      csrf_token = $('meta[name="csrf-token"]').attr('content')
      $.ajaxSetup
        beforeSend: (xhr, settings) ->
          if (csrf_token)
            xhr.setRequestHeader('X-CSRF-Token', csrf_token)
          xhr.setRequestHeader "Accept", "application/skynet-v1+json"

      @$("#fileupload").fileupload
        formData: [{name: "current_user_id", value: @options.current_user_id}, {name: 'custom_data', value: JSON.stringify(@options.custom_data)}]
        dataType: "json"
        add: (e, data) =>
          if @options.file_types != undefined
            types = @options.file_types
          else
            types = /(\.|\/)(gif|jpe?g|png|pdf|doc|docx|csv)$/i
          #          types = /(\.|\/)(gif|jpe?g|png|pdf|doc|docx|csv)$/i
          file = data.files[0]
          if types.test(file.type) || types.test(file.name)
            @$(".row").hide()
            @$(".progress").show()
            #            @$(".meter")
            @$(".meter").css("width", "0%").show()
            data.submit()
          else
#            alert("#{file.name} is not a gif, jpeg, or png image file")
            alert("#{file.name} is not a valid file.")
        progress: (e, data) =>
          progress = parseInt(data.loaded / data.total * 100, 10)
          @$(".meter").css('width', progress + '%')
          @$("#meter-text").html("<span>#{progress}% uploaded...</span>")
        done: (e, data) =>
          result = JSON.parse(data.jqXHR.responseText)
          @$(".progress").before("<a class='label secondary radius uploaded-link' data-params=#{data.jqXHR.responseText} href="+ result.url  +  ">"+ "<i class='icon-link icon-large'></i> " + result.file_name + "</a>")
          @$(".progress").hide()
          @$("#meter-text").html("")
          SkynetExternalApp.vent.trigger("SkynetExternalApp:FileUploader:upload_complete", result)
        error: (e, data) =>
          SkynetExternalApp.vent.trigger("SkynetExternalApp:FileUploader:upload_error")

    showUploadInput: (event) ->
      event.preventDefault()
      #      $(event.target).hide()
      #      @$("span,i").hide()
      $(event.target).parent().next().click()
#      $(event.target).next().click()

#    resetUploader: (data) =>
#      @$(".uploaded-link").remove()
#      @$(".upload").show()

    serializeData: ->
      {style: @options.style}



  FileUploader
