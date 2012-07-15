class Styledujour.Collections.OutfitsCollection extends Backbone.Collection
  model: Styledujour.Models.Outfit
  url: (models) ->
  	return '/outfits/' + ( models ? 'set/' + _.pluck( models, 'id' ).join(';') + '/' : '' ) 
