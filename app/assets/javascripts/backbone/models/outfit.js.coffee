class Styledujour.Models.Outfit extends Backbone.Model
  paramRoot: 'outfit'
  url: ->
  	if(@id != undefined)
  	  "/closets/#{@attributes.closet_id}/outfits/#{@id}"
  	else
  	  "/closets/#{@attributes.closet_id}/outfits"

  defaults:
    name: null
    closet_id: null
    outfit_image_base64: null
    outfit_image: null
    info: null

