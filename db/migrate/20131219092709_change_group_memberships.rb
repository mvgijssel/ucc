class ChangeGroupMemberships < ActiveRecord::Migration
  def up
    rename_column :group_memberships, :group_id, :user_group_id
  end

  def down
    rename_column :group_memberships, :user_group_id, :group_id
  end
end
