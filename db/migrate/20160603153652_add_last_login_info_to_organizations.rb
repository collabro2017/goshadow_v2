class AddLastLoginInfoToOrganizations < ActiveRecord::Migration
  
  def change
    add_column :organizations, :last_activity_user_id, :integer
    add_column :organizations, :last_activity_time, :datetime
  end

  def down
    remove_column :organizations, :last_activity_user_id
    remove_column :organizations, :last_activity_time
  end

end
