class CreateAccommodations < ActiveRecord::Migration
  def change
    create_table :accommodations do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
