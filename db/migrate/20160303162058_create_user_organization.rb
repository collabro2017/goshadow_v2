class CreateUserOrganization < ActiveRecord::Migration
  
  def up  
    create_table :user_organizations do |t|
      t.timestamps
      t.integer :user_id, null: false
      t.integer :organization_id, null: false
      t.string :role, null: false
    end
    add_index :user_organizations, [:user_id, :organization_id], unique: true
  end

  def down
    drop_table :user_organizations
  end

end
