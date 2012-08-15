Styledujour.Views.Outfits ||= {}

class Styledujour.Views.Outfits.NewView extends Backbone.View
  template: JST["backbone/templates/outfits/new"]

  events:
    "submit #new-outfit": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()
    @model.attributes.closet_id = options.closet_id
    @model.bind("change:errors", () =>
      this.render()
    )
    outfit_canvas.init('canvas')
    
    window.scrollTo(0, 1) # Remove Address Bar Mobile
    
    # Automatically Call Draw (This fixes the loading bug)

    drawCanvasInit()

    outfit_canvas.loadSide(@options.clothing_items.toJSON())

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")
    canvasData = outfitCanvasSave()
    @model.attributes.outfit_image_base64 = canvasData["img"]
    @model.attributes.info = canvasData["info"]

    @collection.create(@model.toJSON(),
      success: (outfit) =>
        @model = outfit
        window.location.hash = "/#{@model.id}"

      error: (outfit, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})

      wait: true
    )

  render: ->

    $(@el).html(@template(@model.toJSON() ))

    this.$("#new-outfit").backboneLink(@model)

    return this
