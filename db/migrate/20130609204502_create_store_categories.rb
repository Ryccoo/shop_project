class CreateStoreCategories < ActiveRecord::Migration
  def change
    create_table :store_categories do |t|
      t.string :name
      t.integer :belongs_to

      t.timestamps
    end
  end
end
