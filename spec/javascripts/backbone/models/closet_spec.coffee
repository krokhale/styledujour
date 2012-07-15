describe "closet model", ->
  
  describe "when instantiated", ->

    it "should have default attributes", ->
      closet = new Styledujour.Models.Closet()
      expect(closet.get("name")).toEqual(null)
 
