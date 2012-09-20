class Styledujour.Models.ClothingItem extends Backbone.Model
  paramRoot: 'clothing_item'
  url: ->
  	'/clothing_items/' + @id + '.json'

  initialize: (options) ->
  	if options
  	  @id = options.id 
  	  this.user_scored_clothing_item = new Styledujour.Models.UserScoredClothingItem({id: @id})
  	  this.user_scored_clothing_item.fetch()
  	  this.setPhoto()


  setPhoto: ->
  	if this.attributes.imageurl == null
  	  this.attributes.photo = this.attributes.photo_url
    else
      this.attributes.photo = this.attributes.imageurl

  defaults:
  	photo: null