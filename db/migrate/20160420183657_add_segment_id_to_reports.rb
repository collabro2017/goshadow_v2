class AddSegmentIdToReports < ActiveRecord::Migration
  
  def up
    add_column :reports, :segment_id, :integer
  end

  def down
    remove_column :reports, :segment_id
  end

end
