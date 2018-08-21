class AddGroupIdToReference < ActiveRecord::Migration
  
  def up
    add_column :references, :group_id, :integer
  end

  def down
    remove_column :references, :group_id
  end

end
