class Styledujour.Models.Stylist extends Backbone.Model
  paramRoot: 'stylist'

  defaults:
    actor_id: null
    youtube_video: null
    about_me: null
    facebook: null
    twitter: null
    google: null
    pinterest: null
    website: null
    phone: null

class Styledujour.Collections.StylistsCollection extends Backbone.Collection
  model: Styledujour.Models.Stylist
  url: '/stylists'
