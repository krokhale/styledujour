define ['marionette', "backbone/templates/apps/admissions_app/menu"], (Marionette, template) ->
#        "backbone/apps/attendance_app/attendance_app_models"], (Marionette, template, AttendanceappModels) ->
    SkynetApp = require('app')
    class Menu extends Marionette.ItemView

      template: template

      className: 'row ten columns centered'

      events:
        "click #show-total": 'showTotal'
        "click #show-today": 'showToday'
        "click #show-all": 'showAll'

      initialize: ->
        SkynetApp.vent.on('appFetched', @render)

      onRender: ->
        SkynetApp.CurrentApp.Models

      showTotal: (event) ->
        event.preventDefault()
        users = new SkynetApp.CurrentApp.Models.AdmissionUsers
        users.fetch({success: @buildTable})


      showToday: (event) ->
        event.preventDefault()
        users = new SkynetApp.CurrentApp.Models.AdmissionUser
        users.fetch({data: {show_today: true}, success: @buildTable})


      showAll: (event) ->
        event.preventDefault()
        users = new SkynetApp.CurrentApp.Models.AdmissionUser
        users.fetch({success: @buildTable})

      buildTable: (users) ->
        SkynetApp.vent.trigger('showRows', users)

      serializeData: ->
        if SkynetApp.CurrentApp.get('app_data')
          {today: SkynetApp.CurrentApp.get('app_data').today_users_count, total: SkynetApp.CurrentApp.get('app_data').total_users_count}


    Menu