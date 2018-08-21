class AddStripePlanIdAndCustomerIdToOrganizations < ActiveRecord::Migration
  
  def up
    add_column :organizations, :stripe_plan_id, :string
    add_column :organizations, :stripe_customer_id, :string
  end

  def down
    remove_column :organizations, :stripe_plan_id
    remove_column :organizations, :stripe_customer_id
  end
  
end
