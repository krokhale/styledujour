define ['marionette', 'backbone', 'backbone/routers/app_router', 'pusher', 'models', 'backbone/authorizations'], (Marionette, Backbone, AppRouter, Pusher, Models, Authorizations) ->
  SkynetApp = new Marionette.Application

  SkynetApp.ChatThreads = new Models.ChatThreads
#  SkynetApp.vent = new Marionette.EventAggregator()
  SkynetApp.Auth = new Authorizations


  SkynetApp.setupApp = ->
    SkynetApp.pusherInit()
    csrf_token = $('meta[name="csrf-token"]').attr('content')
    SkynetApp.currentEditor = new nicEditor({fullPanel: true})
    SkynetApp.setupData()
    sync = Backbone.sync
    Backbone.sync = (method, model, options) ->
      options.beforeSend = (xhr, settings) ->
        if settings.data == undefined
          new_data = $.extend({}, {})
          original_url = settings.url
          settings.url = "api/" + original_url
        else
          new_data = $.extend({}, JSON.parse(settings.data), {current_user_id: SkynetApp.CurrentUser.id})
          original_url = settings.url
          settings.url = "api/" + original_url
#        settings.setConcontentType = "application/json"
        settings.data = JSON.stringify(new_data)
        if (csrf_token)
          xhr.setRequestHeader('X-CSRF-Token', csrf_token)
        xhr.setRequestHeader "Content-Type","application/json"
        xhr.setRequestHeader "Accept", "application/skynet-v1+json"
        xhr.setRequestHeader 'X-Pusher-Socket-ID', SkynetApp.Pusher.connection.socket_id
      sync method, model, options
    #  Backbone.history.start({root: "#{window.location.pathname}"})
    SkynetApp.AppRouter = new AppRouter()
    Backbone.history.start()
    SkynetApp.setupChannels()
    SkynetApp.CurrentSession.fetch()


  SkynetApp.pusherInit = ->
    SkynetApp.Pusher = new Pusher('7fad32af360644508b4f')

  SkynetApp.setupData = ->
    SkynetApp.CurrentUser = new Models.User($(".data").data().params.user)
    SkynetApp.CurrentCollege = new Models.College($(".data").data().params.college)
#    SkynetApp.ChatUsers = new Models.Users($(".data").data().params.chat_users)

    SkynetApp.CurrentSession = new Models.UserSessions
#    SkynetApp.CurrentUser.feeds = new Models.Feeds($(".data").data().params.feeds)
    SkynetApp.Models = Models
    SkynetApp.ChatUsers = new SkynetApp.Models.CustomItems
#    SkynetApp.currentResource = {}
#    SkynetApp.CurrentUser.followers = new Models.Follower($(".data").data().params.followers)
#    SkynetApp.CurrentUser.followers.followers = true
#    SkynetApp.CurrentUser.following = new Models.Users($(".data").data().params.following)
#    SkynetApp.CurrentUser.following.following = true

  SkynetApp.setupChannels = ->
    channel = SkynetApp.Pusher.subscribe("presence-channel-#{SkynetApp.CurrentCollege.get('slug')}")
    channel.bind "pusher:subscription_succeeded", (members) =>
      members.each (member) =>
        SkynetApp.ChatUsers.add(member)
    SkynetApp.Pusher.subscribe("private-channel-data-#{SkynetApp.CurrentUser.id}")
    SkynetApp.Pusher.subscribe("presence-channel-chat-#{SkynetApp.CurrentUser.id}")

  SkynetApp.timeSince = (date) ->
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

  SkynetApp.initTabs = (el) ->
    $el = el
    $nav = $el.find('ul.tab-nav > li')
    $content = $el.find('.tab-content')

    $el.find('ul.tab-nav > li').click (event) =>
      event.preventDefault()
      index = $(event.target).parent().index()
      $nav.add($content).removeClass('active')
      $nav.eq(index).add($content.eq(index)).addClass('active')


  SkynetApp

  #SkynetApp.addInitializer (option) ->
  #  SkynetApp.setupApp()



