class CreateUserComments < ActiveRecord::Migration
  def change
    create_table :user_comments do |t|
      t.string :author
      t.text :text
      t.references :user

      t.timestamps
    end
    add_index :user_comments, :user_id
  end
end
