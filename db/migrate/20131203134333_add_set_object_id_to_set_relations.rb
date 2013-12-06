class AddSetObjectIdToSetRelations < ActiveRecord::Migration
  def change
    add_column :set_relations, :set_object_id, :integer
  end
end
