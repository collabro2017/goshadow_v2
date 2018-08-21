class CreateUserExperiences < ActiveRecord::Migration
  
  def up
    create_table :user_experiences do |t|
      t.timestamps
      t.integer :user_id, null: false
      t.integer :experience_id, null: false
    end
    add_index :user_experiences, [ :user_id, :experience_id ], unique: true
  end

  def down
    drop_table :user_experiences
  end

end
