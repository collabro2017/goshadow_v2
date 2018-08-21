class CreateUserSegments < ActiveRecord::Migration
  
  def up
    create_table :user_segments do |t|
      t.timestamps 
      t.integer :user_id, null: false
      t.integer :segment_id, null: false
    end
    add_index :user_segments, [:user_id, :segment_id], unique: true
  end

  def down
    drop_table :user_segments
  end

end
