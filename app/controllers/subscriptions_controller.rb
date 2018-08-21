class SubscriptionsController < ApplicationController

  before_filter :authenticate_user!
  layout 'organization'
  
  def new
    @organization = Organization.find(params['organization_id'])
    @organization.save_user_activity(current_user)
    @subscription_plans = [ nil, ['Single License', '1'], [ '10 Licenses', '2' ], [ '25 Licenses', '3' ] ]
  end

  def create
    @organization = Organization.find(params['organization_id'])
    if params['plan_id'] && EmailValidator.valid?(params['billing_email'])
      @organization.create_customer(params['stripe_token'], params['billing_email'], params['plan_id'])
      render json: @organization, status: :ok
    else
      render status: 400
    end
  end

  def edit
    @organization = Organization.find(params['organization_id'])
    @subscription_plans = [ nil, ['Single License', '1'], [ '10 Licenses', '2' ], [ '25 Licenses', '3' ] ]
  end

  def update
    @organization = Organization.find(params['organization_id'])
    if params['plan_id'] && EmailValidator.valid?(params['billing_email'])
      @organization.update_subscription(params['plan_id'], params['billing_email'])
      flash['notice'] = 'Subscription Updated'
      redirect_to organization_settings_path(@organization) 
    else
      flash['alert'] = 'Select Plan and add valid billing email.'
      redirect_to :back
    end
  end

  def cancel
    @organization = Organization.find(params['organization_id'])
    @organization.cancel_subscription
    flash['notice'] = 'Canceled Subscription.'
    redirect_to organization_settings_path(@organization)
  end

end