class CreateStoreProducts < ActiveRecord::Migration
  def change
    create_table :store_products do |t|
      t.string :name
      t.text :description
      t.integer :sold_count
      t.integer :available_count

      t.timestamps
    end
  end
end
