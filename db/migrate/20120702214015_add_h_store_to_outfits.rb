class AddHStoreToOutfits < ActiveRecord::Migration
  def change
  	add_column :outfits, :info, :hstore #data blob...no index needed yet
  end
end
