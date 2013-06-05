class CreateGroupRights < ActiveRecord::Migration
  def change
    create_table :groups_rights do |t|
      t.references :group
      t.references :right

      t.timestamps
    end
  end
end
