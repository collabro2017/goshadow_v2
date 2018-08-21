class UsersController < ApplicationController

  layout 'organization'
  
  def edit
    @user = User.find(params['id'])
    @user.build_avatar if @user.avatar.nil?
    @organizations = @user.organizations
    @organization = current_org
  end

  def update
    @user = User.find(params['id'])
    if @user.update(user_params)
      flash['notice'] = 'Saved Changes'
      redirect_to :back
    else
      @organization = current_org
      flash['alert'] = format_errors(@user)
      render :edit
    end
  end

  def edit_password
    @user = current_user
    @organization = current_org
  end

  def update_password
    @user = current_user
    if @user.update(user_params)
      sign_in @user, bypass: true
      flash['notice'] = 'password changed'
      redirect_to edit_user_path(@user)
    else
      flash['alert'] = format_errors(@user)
      redirect_to :back
    end
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation, avatar_attributes: [
        :assetable_id, :assetable_type, :attachment, :type
      ]
    )
  end

end