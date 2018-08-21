class CreateReferences < ActiveRecord::Migration
  
  def change
    create_table :references do |t|
      t.timestamps
      t.integer :organization_id, null: false
      t.string :name, null: false
      t.string :type, null: false
      t.integer :created_by_id, null: false
    end
    add_index :references, [:name, :type, :organization_id], unique: true
  end

  def down
    drop_table :references
  end

end