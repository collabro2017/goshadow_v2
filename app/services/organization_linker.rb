class OrganizationLinker

  def initialize(user, invite)
    @user = user
    @invite = invite
  end

  def find_invites
    @invites = Invite.where(email: @invite.email) 
  end

  def give_access
    @invites.each do |invite|
      user_organization = UserOrganization.find_or_create_by(user_id: @user.id, organization_id: invite.organization_id)
      user_organization.update(role: invite.organization_role)
      UserExperience.find_or_create_by(user_id: @user.id, experience_id: @invite.experience_id)
      UserSegment.find_or_create_by(user_id: @user.id, segment_id: @invite.segment_id)
      invite.destroy
    end
  end

end