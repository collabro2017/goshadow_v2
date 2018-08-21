class AddSystemAdminToUsers < ActiveRecord::Migration
  
  def up
    add_column :users, :system_admin, :boolean, default: false
  end

  def down
    remove_column :users, :system_admin
  end

end
