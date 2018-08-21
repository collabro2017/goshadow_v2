class OrganizationShadowerInvite 

  def initialize(invite)
    @invite = invite
    @user = User.find_by_email(@invite.email)
    @organization = Organization.find(@invite.organization_id)
  end

  def run
    if @user
      invite_existing_user
    else
      invite_new_user
    end
  end

  def invite_existing_user
    add_to_experience
    add_to_segment
    add_to_org
    InviteShadowerMailer.exisiting_user(@user, @invite).deliver
  end

  def add_to_org
    user_organization = UserOrganization.find_or_create_by(user: @user, organization: @organization)
    user_organization.update(role: @invite.organization_role)
  end

  def add_to_experience
    if @invite.experience_id
      UserExperience.find_or_create_by(user: @user, experience_id: @invite.experience_id)
    end
  end

  def add_to_segment
    if @invite.segment_id
      UserSegment.find_or_create_by(user: @user, segment_id: @invite.segment_id)
    end
  end

  def invite_new_user
    @invite.save
    InviteShadowerMailer.new_user(@invite).deliver_now
  end

end