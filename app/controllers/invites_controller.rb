class InvitesController < ApplicationController

  def create
    @invite = Invite.new(invite_params)
    if @invite.valid?
      @invite.notify_invitee
      render nothing: true
    else
      render json: { errors: format_errors(@invite) }, status: :unprocessable_entity
    end
  end

  def destroy
    @invite = Invite.find(params['id'])
    @invite.destroy
    render nothing: true
  end

  private

  def invite_params
    params.require(:invite).permit(:organization_id, :invited_by_id, :email, :experience_id, :segment_id, :name, :organization_role, :token)
  end

end