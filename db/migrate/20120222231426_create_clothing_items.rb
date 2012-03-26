class CreateClothingItems < ActiveRecord::Migration
  def self.up
    create_table :clothing_items do |t|
      t.string :name
      t.decimal :price, :precision => 8, :scale => 2
      t.text :description
      t.string :imageurl
      t.string :currency
      t.integer :retailer_id
      t.integer :manufacturer_id
      t.integer :heir_id
      t.string  :heir_type
      t.timestamps
    end
    
		add_index :clothing_items, :heir_type
		add_index :clothing_items, :heir_id
  end

  def self.down
		remove_index :clothing_items, :heir_id
		remove_index :clothing_items, :heir_type
    drop_table :clothing_items
  end
end
