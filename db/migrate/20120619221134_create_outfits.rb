class CreateOutfits < ActiveRecord::Migration
  def change
    create_table :outfits do |t|
      t.string :name
      t.integer :closet_id
      t.integer :activity_object_id
      #image
      #data blob
      t.timestamps
    end
    
    create_table :clothing_items_outfits, :id => false do |t|
      t.references :clothing_items
      t.references :outfits
    end
    
		add_index :outfits, :closet_id
		add_index :outfits, :activity_object_id
		
		add_index :clothing_items_outfits, [:clothing_item_id, :outfit_id]
		add_index :clothing_items_outfits, [:outfit_id, :clothing_item_id]
		
  end
end
