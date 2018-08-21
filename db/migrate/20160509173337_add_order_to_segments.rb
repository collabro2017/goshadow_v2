class AddOrderToSegments < ActiveRecord::Migration
  
  def up
    add_column :segments, :sort_order, :integer
  end

  def down
    remove_column :segments, :sort_order
  end

end
