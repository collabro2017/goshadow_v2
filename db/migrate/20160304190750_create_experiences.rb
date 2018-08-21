class CreateExperiences < ActiveRecord::Migration
  
  def up
    create_table :experiences do |t|
      t.timestamps
      t.integer :organization_id, null: false
      t.string :name, null: false
      t.text :description
      t.string :location      
    end
  end

  def down
    drop_table :experiences
  end
  
end
