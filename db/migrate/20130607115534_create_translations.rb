class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.text :base
      t.string :location
      t.text :en
      t.text :sk

      t.timestamps
    end
  end
end
