class RemoveNullFalseOrganizationTeamSize < ActiveRecord::Migration
  
  def up
    change_column :organizations, :team_size, :string, null: true
  end

  def down
    change_column :organizations, :team_size, :string, null: false
  end

end
