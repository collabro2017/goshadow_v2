class RemoveGroupIdFromReferences < ActiveRecord::Migration
  
  def up
    remove_column :references, :group_id
  end

  def down
    add_column :references, :group_id, :integer
  end
  
end
