class OutfitPaperclip < ActiveRecord::Migration
  def up
  	change_table :outfits do |t|
  	  t.remove :outfit_image
  	  t.string   "outfit_image_file_name"
      t.string   "outfit_image_content_type"
      t.string   "outfit_image_file_size"
      t.boolean  "outfit_image_processing"
  	end
  end

  def down
  end
end
