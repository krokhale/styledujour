Styledujour.Views.Hcit ||= {}

class Styledujour.Views.Hcit.ClothingItemView extends Backbone.View
  template: JST["backbone/templates/hcit/clothing_item"]

  events:
    "click #add-to-closet" : "addToCloset"

  tagName: "div"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this


  addToCloset:  (e) ->
    e.preventDefault()
    $.ajax({
      type: 'POST',
      beforeSend: (xhr) ->
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      url: '/clothing_items/'+@model.attributes.id+'/add_to_closet',
      dataType: 'json',
      success: (data, textStatus, jqXHR) ->
        alert('added to closet')
      failure: (data, textStatus, jqXHR) ->
        alert('failed') 
      })