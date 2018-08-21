class CreateOrganizations < ActiveRecord::Migration
  
  def up
    create_table :organizations do |t|
      t.timestamps
      t.string :name, null: false
      t.string :team_size, null: false
    end
  end

  def down
    drop_table :organizations
  end

end
