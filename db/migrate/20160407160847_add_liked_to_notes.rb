class AddLikedToNotes < ActiveRecord::Migration

  def up
    add_column :notes, :liked, :boolean
  end

  def down
    remove_column :notes, :liked
  end

end