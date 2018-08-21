class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include TimeHelpers

  protect_from_forgery with: :exception

  helper_method :format_errors, :api_errors, :current_org, :convert_seconds_to_time, :date_time_to_date, 
  :users_organization_role, :is_coordinator, :shadower, :org_coordinators, :not_found, :subscription_check

  def format_errors(object)
    object.errors.full_messages.uniq.join('</br>')
  end

  def api_errors(object)
    object.errors.full_messages.uniq
  end

  def authenticate_user!
    redirect_to new_user_session_path unless current_user
  end

  def current_org
    @organization = Organization.find(session['organization_id'])
  end

  def date_time_to_date(datetime)
    datetime.strftime("%_m/%e/%Y")
  end

  def users_organization_role
    return UserOrganization::COORDINATOR if current_user.system_admin
    UserOrganization.find_by(user: current_user, organization: current_org).role
  end

  def shadower
    users_organization_role == UserOrganization::SHADOWER
  end

  def is_coordinator
    users_organization_role == UserOrganization::COORDINATOR
  end

  def org_coordinators
    coordinator_ids = current_org.user_organizations.where(role: UserOrganization::COORDINATOR).pluck(:user_id)
    User.where(id: coordinator_ids)
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def subscription_check
    org = current_org
    if ( org.remaining_trial_time < 0 ) && org.stripe_plan_id.nil?
      flash['notice'] = 'Your free trial is over you must sign up for a subscription to continue using the GoShadow Platform.'
      redirect_to new_organization_subscription_path(org)
    end
  end

end