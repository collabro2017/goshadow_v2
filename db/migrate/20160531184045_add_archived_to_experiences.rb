class AddArchivedToExperiences < ActiveRecord::Migration
  
  def change
    add_column :experiences, :archived, :boolean, default: false
  end

  def down
    remove_column :experiences, :archived
  end

end
