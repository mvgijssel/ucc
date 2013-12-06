class CreateSetRelations < ActiveRecord::Migration
  def change
    create_table :set_relations do |t|
      t.integer :set_id
      t.integer :set_container_id

      t.timestamps
    end
  end
end
