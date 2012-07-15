class Styledujour.Collections.ClothingItemsCollection extends Backbone.Paginator.requestPager
  model: Styledujour.Models.ClothingItem
 
  initialize: (attributes) ->
  	if (attributes != undefined)
  		@closet_id = attributes.closet_id

  paginator_core: 
  	type: 'GET',
  	dataType: 'json',
  	url: ->
  		if(@closet_id == undefined)
  			'/clothing_items'
  		else
  			'/closets/' + @closet_id + '/clothing_items'

  paginator_ui:
  	firstPage: 1,
  	currentPage: 1,
  	perPage: 10,
  	totalPages: 10

  server_api:
  	'page' : ->
  		this.currentPage
  	'filter' : '',
  	'top': ->
  		this.perPage
  	'skip': ->
  		this.currentPage * this.perPage	
  	'orderby': 'CreatedAt',
  	'format': 'json',
  	'inlinecount': 'allpages'

  parse: (response) ->
  	tags = response.resources
  	this.totalPages = response.pagination.total_pages
  	this.currentPage = response.pagination.current_page
  	return tags