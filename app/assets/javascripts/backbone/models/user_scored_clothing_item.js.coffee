class Styledujour.Models.UserScoredClothingItem extends Backbone.Model
  paramRoot: 'user_scored_clothing_item'
  url: '/clothing_items/:id/user_scored_clothing_item'

  initialize: (options) ->
  	this.url = '/clothing_items/' + options.id + '/user_scored_clothing_item'