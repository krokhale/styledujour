describe "outfit model", ->
  
  describe "when instantiated", ->

    it "should have default attributes", ->
      outfit = new Styledujour.Models.Outfit()
      expect(outfit.get("name")).toEqual(null)
      expect(outfit.get("closet_id")).toEqual(null)
      expect(outfit.get("outfit_image")).toEqual(null)
      expect(outfit.get("info")).toEqual(null)
      expect(outfit.get("update_at")).toEqual(null)
      expect(outfit.get("created_at")).toEqual(null)
 
