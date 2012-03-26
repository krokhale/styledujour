class Styledujour.Models.LinkedClothingItem extends Backbone.Model
  paramRoot: 'linked_clothing_item'

  defaults:
    name: null
    price: null
    description: null
    imageurl: null
    item_url: null

class Styledujour.Collections.LinkedClothingItemsCollection extends Backbone.Collection
  model: Styledujour.Models.LinkedClothingItem
  url: '/linked_clothing_items'
