module InviteMethods

  def notify_invitee
    shadower_invite = OrganizationShadowerInvite.new(self)
    shadower_invite.run
  end

end