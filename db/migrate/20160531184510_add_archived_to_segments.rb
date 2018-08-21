class AddArchivedToSegments < ActiveRecord::Migration
  
  def up
    add_column :segments, :archived, :boolean, default: false
  end

  def down
    remove_column :segments, :archived
  end

end
