class AddPublishedToExperiences < ActiveRecord::Migration
  
  def up
    add_column :experiences, :published, :boolean, default: false
  end

  def down
    remove_column :experiences, :published
  end

end
