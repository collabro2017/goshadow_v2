class CreateGroups < ActiveRecord::Migration
  
  def up
    create_table :groups do |t|
      t.timestamps
      t.integer :organization_id, null: false
      t.string :name, null: false
      t.string :type, null: false
    end
    add_index :groups, [:organization_id, :name, :type], unique: true
  end

  def down
    drop_table :groups
  end

end
