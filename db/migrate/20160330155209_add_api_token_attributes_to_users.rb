class AddApiTokenAttributesToUsers < ActiveRecord::Migration
  
  def up
    add_column :users, :api_token, :string
    add_column :users, :api_last_activity, :datetime
    add_index :users, :api_token, unique: true
  end

  def down
    remove_column :users, :api_last_activity
    remove_column :users, :api_token
  end

end