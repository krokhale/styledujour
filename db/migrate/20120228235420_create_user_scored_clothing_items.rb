class CreateUserScoredClothingItems < ActiveRecord::Migration
  def change
    create_table :user_scored_clothing_items, :id=>false do |t|
      t.integer :user_id, :null => false
      t.integer :clothing_item_id, :null => false
      t.decimal :price
      t.boolean :love

      t.timestamps
    end
    
        
    add_index :user_scored_clothing_items, :user_id
    add_index :user_scored_clothing_items, :clothing_item_id
    add_index :user_scored_clothing_items, :love
  end
end
