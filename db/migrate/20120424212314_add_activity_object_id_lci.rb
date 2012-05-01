class AddActivityObjectIdLci < ActiveRecord::Migration
  def up
		add_column :linked_clothing_items, :activity_object_id, :integer  
  end

  def down
    remove_column :linked_clothing_items, :activity_object_id
  end
end
