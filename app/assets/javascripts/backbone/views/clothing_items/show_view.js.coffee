Styledujour.Views.ClothingItems ||= {}

class Styledujour.Views.ClothingItems.ShowView extends Backbone.View
  template: JST["backbone/templates/clothing_items/show"]

  events:
    "click #inviteFacebook" : "inviteFacebook",
    "click #postFacebookWall" : "postFacebookWall"

  render: ->
    @model.user_scored_clothing_item = new Styledujour.Models.UserScoredClothingItem({id: @model.attributes.id})
    @model.user_scored_clothing_item.fetch()
    
    $(@el).html(@template(@model ))

    this.$el.find( "#dollar-slider" ).slider({max: 1000, step: 5, value: 0, slide: (event,ui) =>    
      $("#dollar-amount").text(ui.value)
      $("#user_scored_clothing_item_price").val(ui.value)
    })

    submit_form_with: (feelings) ->
      if (feelings == 'shop')
        $('#user_scored_clothing_item_love').val(true)
      else
        $('#user_scored_clothing_item_love').val(false)
        
      $('#new_user_scored_clothing_item').submit()
   
    this.$el.find('#hcit_form').modal({show: false})
    this.$el.find('#hcit_form').on('show', ->
        $.get('/clothing_items/'+@model.attributes.id+'/hcit_form.html', (data) => 
         $('.modal-body').html(data)
        );
      );
              
    hideModal: ->
     $('#hcit_form').modal('hide')
     
    this.$el.find('#what-is-hcit').popover({placement:'bottom'})
    this.$el.find('#what-is-cute').popover({placement:'bottom'})
    
           
    return this

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
           appId:'6194336540', 
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
             appId:'6194336540', 
             cookie:true, 
             status:true
             
          }
    FB.ui { method: 'apprequests', message: 'How Cute Is This?.'}, this.fbInviteRequestCallback
   
  

  
   
