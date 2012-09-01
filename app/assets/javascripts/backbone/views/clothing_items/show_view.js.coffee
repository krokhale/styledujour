Styledujour.Views.ClothingItems ||= {}

class Styledujour.Views.ClothingItems.ShowView extends Backbone.View
  template: JST["backbone/templates/clothing_items/show"]

  events:
    "click #inviteFacebook" : "inviteFacebook",
    "click #postFacebookWall" : "postFacebookWall",
    "click #hcit-shop-it" : "submitShopIt",
    "click #hcit-drop-it" : "submitDropIt"

  render: ->
    console.log(@model.user_scored_clothing_item.toJSON())

    $(@el).html(@template(@model ))

    if (@model.user_scored_clothing_item.love == undefined) 
      this.$el.find( "#dollar-slider" ).slider({max: 1000, step: 5, value: 0, slide: (event,ui) =>    
        $("#dollar-amount").text(ui.value)
        $("#user_scored_clothing_item_price").val(ui.value)
      })

     
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

  submitShopIt: ->

    this.$el.find('#user_scored_clothing_item_love').val(true)

    this.submitHCITScore(this)

  submitDropIt: ->

    this.$el.find('#user_scored_clothing_item_love').val(false)
    this.submitHCITScore(this)


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
   
  submitHCITScore: (that)->
    newModel = {}
    that.$el.find("#new_user_scored_clothing_item").children("input").each( 
      (i, el) ->
        if ($(el).val() != "") 
            newModel[el.name] = $(el).val()
    )
    hcitScore = new Styledujour.Models.UserScoredClothingItem( newModel )
    hcitScore.url = "/clothing_items/" + @model.attributes.id + "/hcit_score.json"
    hcitScore.save({}, 
      success: (model, resp) ->
        that.$el.find('#hcit-score-form').html(resp.message)

      error: (model, resp) ->
        json =eval("("+resp.responseText+")")
        that.$el.find('#hcit-score-form').html(json.message)
      )

  
