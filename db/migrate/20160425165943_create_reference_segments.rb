class CreateReferenceSegments < ActiveRecord::Migration
  
  def up
    create_table :reference_segments do |t|
      t.timestamps
      t.integer :reference_id, null: false
      t.integer :segment_id, null: false
    end
    
    add_index :reference_segments, [:reference_id, :segment_id], unique: true

  end

  def down
    drop_table :reference_segments
  end
  
end
