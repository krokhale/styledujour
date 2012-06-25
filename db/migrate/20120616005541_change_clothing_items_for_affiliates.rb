class ChangeClothingItemsForAffiliates < ActiveRecord::Migration
  def up
    remove_column :clothing_items, :retailer_id
		add_column :clothing_items, :gender, :integer, :limit=>1
		add_column :clothing_items, :age, :string
		add_column :clothing_items, :category_id, :integer
		
		create_table :clothing_items_retailers, :id=>false, :force => true do |t|
		    t.references :clothing_item
		    t.references :retailer
		  end
		
		add_index :clothing_items_retailers, [:clothing_item_id, :retailer_id], :name=>"clothing_items_retailers_clothing_retailer"
		add_index :clothing_items_retailers, [:retailer_id ,:clothing_item_id], :name=>"clothing_items_retailers_retailer_clothing"
		add_index :clothing_items, :category_id
  end

  def down
    add_column :clothing_items, :retailer_id, :integer
  end
end
