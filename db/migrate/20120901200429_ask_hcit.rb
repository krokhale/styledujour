class AskHcit < ActiveRecord::Migration
  def change
    
    create_table :ask_hcits do |t|
      t.references :clothing_item, :null => false
      t.integer :sender_id, :null => false
      t.integer :receiver_id, :null => false
      t.references :user_scored_clothing_item
      t.timestamps
    end
    
	add_index :ask_hcits, :clothing_item_id
	add_index :ask_hcits, :receiver_id
	add_index :ask_hcits, :sender_id
	add_index :ask_hcits, :user_scored_clothing_item_id
	
  end

end
