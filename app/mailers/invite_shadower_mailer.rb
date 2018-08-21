class InviteShadowerMailer < ApplicationMailer

  def exisiting_user(user, invite)
    @user = user
    @invite = invite
    @organization = invite.organization
    mail(to: @user.email, subject: "You have been invited to join #{@organization.name} on GoShadow")
  end

  def new_user(invite)
    @invite = invite
    @organization = invite.organization
    mail(to: @invite.email, subject: "You have been invited to join #{@organization.name} on GoShadow")
  end

  def new_experience(user, experience)
    @user = user
    @experience = experience
    mail(to: @user.email, subject: "You have been invited to #{@experience.name}")
  end

end