class Styledujour.Models.Closet extends Backbone.Model
  paramRoot: 'closet'

  defaults:
    name: null

  initialize: (attributes) ->
    this.outfits = new Styledujour.Collections.OutfitsCollection();
    this.outfits.url = '/closets/' + this.id + '/outfits.json'
    this.clothing_items = new Styledujour.Collections.ClothingItemsCollection();
    this.clothing_items.url = '/closets/' + this.id + '/clothing_items.json'

