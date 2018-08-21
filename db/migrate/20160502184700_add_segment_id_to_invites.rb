class AddSegmentIdToInvites < ActiveRecord::Migration
    
  def up
    add_column :invites, :segment_id, :integer
  end

  def down
    remove_column :invites, :segment_id
  end

end