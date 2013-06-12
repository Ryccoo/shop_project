class CreateStoreProducts < ActiveRecord::Migration
  def change
    create_table :store_products do |t|
      t.string :name
      t.text :description
      t.integer :sold_count
      t.integer :available_count
      t.integer :price
      t.integer :price_DPH
      t.string :price_comment

      t.timestamps
    end
  end
end
