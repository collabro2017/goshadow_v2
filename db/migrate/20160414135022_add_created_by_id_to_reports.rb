class AddCreatedByIdToReports < ActiveRecord::Migration
  
  def up
    add_column :reports, :created_by_id, :integer, null: false
  end

  def down
    remove_column :reports, :created_by_id
  end

end
