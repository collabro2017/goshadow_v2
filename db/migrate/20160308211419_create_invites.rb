class CreateInvites < ActiveRecord::Migration
  
  def up
    create_table :invites do |t|
      t.timestamps
      t.integer :organization_id, null: false
      t.integer :invited_by_id, null: false
      t.integer :organization_id, null: false
      t.string :email, null: false
      t.integer :experience_id
      t.string :name, null: false
      t.string :organization_role
      t.string :token, null: false
    end
  end

  def down
    drop_table :invites
  end

end
