class CreateSegments < ActiveRecord::Migration
  
  def up
    create_table :segments do |t|
      t.timestamps
      t.integer :experience_id, null: false
      t.string :name, null: false
      t.string :start_location, null: false
      t.string :end_location, null: false
    end
    add_index :segments, :experience_id
  end
  
  def down
    drop_table :segments
  end

end
