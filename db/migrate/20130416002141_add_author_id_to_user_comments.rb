class AddAuthorIdToUserComments < ActiveRecord::Migration
  def change
    add_column :user_comments, :author_id, :integer
  end
end
