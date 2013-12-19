class ChangeCollectionRelationship < ActiveRecord::Migration
  def up
    change_column :collection_relationships, :set_container_id, :string
    rename_column :collection_relationships, :set_container_id, :collection_type
    rename_column :collection_relationships, :set_id, :collection_id
    rename_column :collection_relationships, :set_object_id, :model_id
    add_column :collection_relationships, :model_type, :string
  end

  def down
    rename_column :collection_relationships, :collection_type, :set_container_id
    change_column :collection_relationships, :set_container_id, :integer
    rename_column :collection_relationships, :collection_id, :set_id
    rename_column :collection_relationships, :model_id, :set_object_id
    remove_column :collection_relationships, :model_type
  end
end
