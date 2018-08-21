class CreateNotes < ActiveRecord::Migration
  
  def up
    create_table :notes do |t|
      t.timestamps
      t.integer :segment_id, null: false
      t.integer :reference_id
      t.string :text
      t.datetime :start_time
      t.integer :seconds, default: 0
    end
  end

  def down
    drop_table :notes
  end

end
