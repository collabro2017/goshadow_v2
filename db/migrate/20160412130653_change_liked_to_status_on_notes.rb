class ChangeLikedToStatusOnNotes < ActiveRecord::Migration
  
  def up
    rename_column :notes, :liked, :status
    change_column :notes, :status, :string
  end

  def down
    rename_column :notes, :status, :liked
    change_column :notes, :liked, 'boolean USING CAST(liked AS boolean)'
  end

end