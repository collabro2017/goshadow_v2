class CreateReferenceGroups < ActiveRecord::Migration
  
  def up
    create_table :reference_groups do |t|
      t.timestamps
      t.integer :reference_id, null: false
      t.integer :group_id, null: false
    end
    add_index :reference_groups, [:reference_id, :group_id], unique: true
  end

  def down
    drop_table :reference_groups
  end

end
