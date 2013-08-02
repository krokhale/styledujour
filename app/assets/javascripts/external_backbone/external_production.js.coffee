define ['marionette', 'backbone', 'external_backbone/routers/app_router', 'external_backbone/models', 'editor'], (Marionette, Backbone, AppRouter, Models, editor) ->
  StyleDujourApp = new Marionette.Application


  StyleDujourApp.setupApp = ->
    csrf_token = $('meta[name="csrf-token"]').attr('content')
    StyleDujourApp.currentEditor = new nicEditor({fullPanel: true})
    StyleDujourApp.setupData()
    sync = Backbone.sync
    Backbone.sync = (method, model, options) ->
      options.beforeSend = (xhr, settings) ->
        if settings.data == undefined
          new_data = $.extend({}, {})
          original_url = settings.url
          settings.url = "/api/" + original_url
        else
          new_data = $.extend({}, JSON.parse(settings.data), {current_app_id: StyleDujourApp.CurrentApp.id})
          original_url = settings.url
          settings.url = "/api/" + original_url
        settings.data = JSON.stringify(new_data)
        if (csrf_token)
          xhr.setRequestHeader('X-CSRF-Token', csrf_token)
        xhr.setRequestHeader "Content-Type","application/json"
        xhr.setRequestHeader "Accept", "application/skynet-v1+json"
      sync method, model, options
    #  Backbone.history.start({root: "#{window.location.pathname}"})
    StyleDujourApp.AppRouter = new AppRouter()
    Backbone.history.start()



  StyleDujourApp.setupData = ->
    StyleDujourApp.CurrentCollege = new Models.College($(".data").data().params)
    StyleDujourApp.CurrentApp = new Models.ExternalApp($(".app").data().params)
    if $(".current_user").length > 0
      StyleDujourApp.CurrentUser = $(".current_user").data().params

    StyleDujourApp.Models = Models


  StyleDujourApp.timeSince = (date) ->
    seconds = Math.floor(((new Date().getTime() / 1000) - date))
    interval = Math.floor(seconds / 31536000)
    return interval + " years ago"  if interval > 1
    interval = Math.floor(seconds / 2592000)
    return interval + " months ago"  if interval > 1
    interval = Math.floor(seconds / 86400)
    return interval + " day ago"  if (interval >= 1 && interval < 2)
    return interval + " days ago"  if interval >= 1
    interval = Math.floor(seconds / 3600)
    return interval + " hour ago"  if (interval >= 1 && interval < 2)
    return interval + " hours ago"  if interval >= 1
    interval = Math.floor(seconds / 60)
    return interval + " minute ago"  if (interval >= 1 && interval < 2)
    return interval + " minutes ago"  if interval > 1
    " less than a minute ago"

  StyleDujourApp.initTabs = (el) ->
    $el = el
    $nav = $el.find('ul.tab-nav > li')
    $content = $el.find('.tab-content')

    $el.find('ul.tab-nav > li').click (event) =>
      event.preventDefault()
      index = $(event.target).parent().index()
      $nav.add($content).removeClass('active')
      $nav.eq(index).add($content.eq(index)).addClass('active')


  StyleDujourApp

