class SettingsController < ApplicationController

  layout 'organization'
  before_filter :coordinator_check

  def index
    if params['subscription_message']
      flash['notice'] = params['subscription_message']
    end
    @organization = Organization.find(params['organization_id'])
    @organization.build_organization_logo if @organization.organization_logo.nil?
    @users = @organization.users.where.not(id: current_user.id)
  end

  def transfer_coordinator
    organization = Organization.find(params['organization_id'])
    current_coordinator = UserOrganization.find_by(user_id: current_user.id, organization_id: organization.id)
    new_coordinator = UserOrganization.find_by(user_id: params['new_coordinator_id'], organization_id: organization.id)
    if new_coordinator
      new_coordinator.update(role: UserOrganization::COORDINATOR)
      current_coordinator.update(role: UserOrganization::SHADOWER)
      flash['notice'] = "Shadowing Coordinator status transfered to #{new_coordinator.user.name}, you are now a Shadower in the #{@organization.name} organization."
      render json: organization, root: false, serializer: nil
    else
      render status: 400
    end
  end

  def coordinator_check
    not_found unless is_coordinator
  end

end