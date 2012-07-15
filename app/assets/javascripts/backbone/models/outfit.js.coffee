class Styledujour.Models.Outfit extends Backbone.Model
  paramRoot: 'outfit'
  url: '/outfits'

  defaults:
    name: null
    closet_id: null
    outfit_image: null
    info: null
    update_at: null
    created_at: null

