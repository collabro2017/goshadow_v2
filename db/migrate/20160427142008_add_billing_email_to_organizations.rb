class AddBillingEmailToOrganizations < ActiveRecord::Migration
  
  def up
    add_column :organizations, :billing_email, :string
  end

  def down
    remove_column :organizations, :billing_email
  end
  
end
