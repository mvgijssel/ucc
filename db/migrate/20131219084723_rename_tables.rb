class RenameTables < ActiveRecord::Migration
  def up
    rename_table :relationships, :group_memberships
    rename_table :set_relations, :collection_relationships
    rename_table :groups, :user_groups
  end

  def down

    rename_table :group_memberships, :relationships
    rename_table :collection_relationships, :set_relations
    rename_table :user_groups, :groups

  end
end
