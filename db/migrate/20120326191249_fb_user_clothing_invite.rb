class FbUserClothingInvite < ActiveRecord::Migration
  def up
		create_table :facebook_user_clothing_invites, :id=>false, :force => true do |t|
		    t.integer :facebook_id, :limit=> 8
		    t.references :user
		    t.references :clothing_item
		    t.boolean :accepted
		    t.timestamps
		  end
		  
		add_index :facebook_user_clothing_invites, :user_id
		add_index :facebook_user_clothing_invites, :facebook_id
		add_index :facebook_user_clothing_invites, :accepted
  end

  def down
    drop_table :facebook_user_clothing_invites
  end
end
