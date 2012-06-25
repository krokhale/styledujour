class CreateRetailers < ActiveRecord::Migration
  def change
    create_table :retailers do |t|
      t.string :name
      t.string :url
      t.string :domain

      t.timestamps
    end
  end
end
