class AddSlugToCloset < ActiveRecord::Migration
  def change
  	add_column :closets, :slug, :string
  end
end
