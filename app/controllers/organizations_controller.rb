class OrganizationsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :needs_to_choose_org?, only: [:index]
  before_filter :save_org_id, except: [:index, :new, :create]
  before_filter :subscription_check, except: [:index, :new, :create, :remove_shadower, :update]
  layout 'organization', except: [:index, :new, :create]

  def index
    @organizations = current_user.organizations
  end

  def update
    @organization = Organization.find(params['id'])
    if @organization.update(organization_params)
      flash['notice'] = "Saved Changes"
      redirect_to organization_settings_path(@organization)
    else
      flash.now['alert'] = format_errors(@organization)
      @organization.build_organization_logo if @organization.organization_logo.nil?
      render 'settings/index'
    end
  end

  def new
    @organization = Organization.new
    @organization.build_organization_logo
  end

  def create
    @organization = Organization.create(organization_params)
    if @organization.save
      UserOrganization.create(user_id: current_user.id, organization_id: @organization.id, role: UserOrganization::COORDINATOR)
      flash['notice'] = 'Organization Created'
      redirect_to experiences_organization_path(@organization)
    else
      @organization.build_organization_logo if @organization.organization_logo.nil?
      flash.now['notice'] = format_errors(@organization) 
      render :new
    end
  end

  def remove_shadower
    @organization = Organization.find(params['id'])
    @organization.remove_shadower(params['user_id'])
    render nothing: true
  end

  def experiences
    @organization = Organization.find(params['id'])
    @organization.save_user_activity(current_user)
    @experience = Experience.new
    @experiences = current_user.accessible_org_experiences(@organization, is_coordinator).paginate(page: params[:page]).decorate
  end
  
  def places
    @organization = Organization.find(params['id'])
    @places = @organization.places
    @place_groups = @organization.place_groups
    @new_place = Place.new
  end

  def persons
    @organization = Organization.find(params['id'])
    @persons = @organization.persons
    @person_groups = @organization.person_groups
    @new_person = Person.new
  end

  def shadowers
    @organization = Organization.find(params['id'])
    @user_organizations = @organization.user_organizations.order('role')
    @invites = @organization.invites
    @invite = Invite.new
  end
     
  def person_groups
    @organization = Organization.find(params['id'])
    @person_groups = @organization.person_groups
    @new_group = Group.new
  end

  def place_groups
    @organization = Organization.find(params['id'])
    @place_groups = @organization.place_groups
    @new_group = Group.new
  end

  private

  def save_org_id
    session['organization_id'] = params['id']
  end

  def needs_to_choose_org?
    if current_user.system_admin
      redirect_to admin_index_path
    elsif current_user.organizations.count <= 1 && current_user.organizations.count
      redirect_to experiences_organization_path(current_user.organizations.first)
    end
  end

  def organization_params
    params.require(:organization).permit(:name, :team_size, :stripe_plan_id, :stripe_customer_id, organization_logo_attributes: [
        :assetable_id, :assetable_type, :attachment, :type
      ]
    )
  end

end