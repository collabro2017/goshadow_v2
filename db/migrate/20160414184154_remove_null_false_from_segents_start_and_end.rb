class RemoveNullFalseFromSegentsStartAndEnd < ActiveRecord::Migration
  
  def up
    change_column :segments, :start_location, :string, null: true
    change_column :segments, :end_location, :string, null: true
  end

  def down
    change_column :segments, :start_location, :string, null: false
    change_column :segments, :end_location, :string, null: false
  end
  
end
