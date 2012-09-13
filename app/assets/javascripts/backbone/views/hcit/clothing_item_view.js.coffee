Styledujour.Views.Hcit ||= {}

class Styledujour.Views.Hcit.ClothingItemView extends Backbone.View
  template: JST["backbone/templates/hcit/clothing_item"]

  events:
    "click #add-to-closet" : "addToCloset",
    "click #bookmark-it" : "bookmark",
    "click #buy-it" : "buyIt",
    "click #post-facebook" : "postFacebookWall",
    "click #invite-friends" : "inviteFacebook"

  tagName: "div"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this


  addToCloset:  (e) ->
    e.preventDefault()
    $.ajax({
      type: 'POST',
      beforeSend: (xhr) ->
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      url: '/clothing_items/'+@model.attributes.id+'/add_to_closet',
      dataType: 'json',
      success: (data, textStatus, jqXHR) ->
        alert('added to closet')
      failure: (data, textStatus, jqXHR) ->
        alert('failed') 
      })

  bookmark: (e) ->
    e.preventDefault()
    $.ajax({
      type: 'POST',
      beforeSend: (xhr) ->
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      url: '/clothing_items/'+@model.attributes.id+'/bookmark',
      dataType: 'json',
      success: (data, textStatus, jqXHR) ->
        alert('bookmarked!')
      failure: (data, textStatus, jqXHR) ->
        alert('Something went wrong!') 
      })

  buyIt: (e) ->
     e.preventDefault()
     window.open(@model.attributes.heir.item_url)

  fbInviteRequestCallback: (response) =>
    model = @model.toJSON()
    $.post('/hcit/fb_request', {'clothing_item_id':model.id, 'fb_ids':response.to, 'request_object_id':response.request}, 
            (data, status) =>
               if(status == "success") 
                 alert('Your Facebook friends have been asked!'); 
            , 'json')
   
  postFacebookWall: =>
   model = @model.toJSON()
   FB.init({ 
           appId:'2355533850', 
           cookie:true, 
           status:true
        });
   FB.ui({
      method: 'feed',  
      name: 'How Cute Is This?',  
      caption: model.name, 
      description: model.description, 
      link: 'http://www.styledujour.com/clothing_items/'+model.id, 
      picture: model.imageurl
    });

  inviteFacebook: =>
    FB.init { 
             appId:'2355533850', 
             cookie:true, 
             status:true
             
          }
    FB.ui { method: 'apprequests', message: 'How Cute Is This?.'}, this.fbInviteRequestCallback     