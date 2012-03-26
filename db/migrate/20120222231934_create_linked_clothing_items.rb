class CreateLinkedClothingItems < ActiveRecord::Migration
  def self.up
    create_table :linked_clothing_items do |t|
      t.string :item_url, :null => false
    end
  end

  def self.down
    drop_table :linked_clothing_items
  end
end
