class RegistrationsController < ApplicationController

  def new
    @user = User.new
    @user.user_organizations.build(role: UserOrganization::COORDINATOR, organization: Organization.new)
  end

  def by_invite
    @invite = Invite.find_by(token: params['token'])
    if @invite
      @user = User.new
      @user.user_organizations.build(role: @invite.organization_role, organization_id: @invite.organization_id)
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def register_from_invite
    @invite = Invite.find_by(token: params['token'])
    @user = User.create(registration_params)
    if @user.save
      @user.link_to_organizations(@invite)    
      sign_in @user
      redirect_to root_path
    else
      flash.now['alert'] = format_errors(@user)
      render :by_invite
    end
  end

  def create
    @user = User.create(registration_params)
    if @user.save
      sign_in @user
      redirect_to root_path
    else
      @errors = format_errors(@user)
      fix_org_error
      flash.now['alert'] = @errors
      render :new
    end
  end

  private

  def fix_org_error
    error_array = @errors.split("</br>")
    org_error_index = error_array.index("User organizations organization name can't be blank")
    if org_error_index
      error_array.delete_at(org_error_index)
      error_array << "Organization name can't be blank."
      @errors = error_array.join("<br>")
    end
  end

  def registration_params
    params.require(:user).permit(:id, :first_name, :last_name, :email, :password, :password_confirmation, 
      user_organizations_attributes: [
        :user_id, :role, organization_attributes: [
          :name, :team_size
        ]
      ]
    )
  end

end