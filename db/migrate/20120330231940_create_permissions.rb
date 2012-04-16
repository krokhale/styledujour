class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :action
      t.string :object
      t.string :function

      t.timestamps
    end
  end
end
