class ShadowersController < ApplicationController

  layout 'organization'
  
  def index
    @experience = Experience.find(params['experience_id'])
    @shadowers = ( org_coordinators + @experience.users ).uniq
    @new_user_experiences = @experience.init_user_experiences
    @invites = @experience.invites
    @invite = Invite.new
    respond_to do |format|
      format.js
    end
  end

end