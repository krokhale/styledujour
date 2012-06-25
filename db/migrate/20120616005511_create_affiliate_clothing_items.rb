class CreateAffiliateClothingItems < ActiveRecord::Migration
  def change
    create_table :affiliate_clothing_items do |t|
      t.integer :activity_object_id
      t.string :item_url
      t.string :mpn
      t.string :upc
      t.string :sku
      t.boolean :is_accessory
      t.string :skimlinks_product_id
      t.integer :skimlinks_group_id

    end
  end
end
