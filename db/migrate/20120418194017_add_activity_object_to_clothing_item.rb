class AddActivityObjectToClothingItem < ActiveRecord::Migration
  def change
		add_column :clothing_items, :activity_object_id, :integer
  end
end
