module OrganizationSubscriptionMethods

  def update_subscription(plan_id, billing_email)
    customer = Stripe::Customer.retrieve(self.stripe_customer_id)
    customer.plan = plan_id
    customer.email = billing_email
    customer.save
    self.update(stripe_plan_id: plan_id, billing_email: billing_email)
  end

  def cancel_subscription
    customer = Stripe::Customer.retrieve(self.stripe_customer_id)
    customer.subscriptions.each do |subscription|
      subscription.delete()
    end
    self.update(stripe_plan_id: nil, stripe_customer_id: nil, billing_email: nil)
  end

  def create_customer(token, billing_email, plan_id)
    customer = Stripe::Customer.create(
      email: billing_email,
      source: token, 
      plan: plan_id
    )
    self.update(stripe_customer_id: customer.id, billing_email: billing_email, stripe_plan_id: plan_id)
  end

end