class CreateClosets < ActiveRecord::Migration
  def change
    create_table :closets do |t|
      t.string :name
      t.integer :actor_id
      t.timestamps
    end
    
    create_table :closets_clothing_items, :id => false do |t|
      t.references :closet
      t.references :clothing_item
    end
    
		add_index :closets, :actor_id
		add_index :closets_clothing_items, [:closet_id, :clothing_item_id], :name=>"closets_clothing_items_closet_item_index"
		add_index :closets_clothing_items, [:clothing_item_id, :closet_id],:name=>"closets_clothing_items_item_closet_index"
  end
end
