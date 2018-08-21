class AddCreatedByIdToSegmentsAndExperiences < ActiveRecord::Migration
  
  def up
    add_column :segments, :created_by_id, :integer
    add_column :experiences, :created_by_id, :integer
  end

  def down
    remove_column :segments, :created_by_id
    remove_column :experiences, :created_by_id
  end

end