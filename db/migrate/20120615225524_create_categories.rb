class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.string :source
      t.integer :source_identifier
      t.timestamps
    end
    
		add_index :categories, :name
		add_index :categories, :parent_id
  end
end
