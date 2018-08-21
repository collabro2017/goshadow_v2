class ExperiencesController < ApplicationController

  layout 'organization'
  before_action :authenticate_user!

  def create
    @experience = Experience.create(experience_params)
    if @experience.save
      current_user.add_to_experience(@experience)
      render json: @experience, root: false, serializer: nil
    else
      render json: { errors: format_errors(@experience) }, status: :unprocessable_entity
    end
  end
  
  def show
    @experience = Experience.find(params['id'])
    @organization = current_org
    @tab = params['tab'] || 'segments'
    @invite = Invite.new
  end

  def update
    @experience = Experience.find(params['id'])
    @experience.update(experience_params)
    if @experience.save
      add_shadowers_to_segments
      render nothing: true
    else
      render json: { errors: format_errors(@experience) }, status: :unprocessable_entity
    end
  end

  def destroy
    @experience = Experience.find(params['id'])
    @experience.archive
    render nothing: true
  end

  def remove_shadower
    @experience = Experience.find(params['experience_id'])
    @experience.remove_user(params['user_id'])
    render nothing: true
  end

  def clone
    @experience = Experience.find(params['id'])
    experience_cloner = ExperienceCloner.new(@experience)
    experience_cloner.run
    flash['notice'] = "#{@experience.name} cloned successfully."
    redirect_to :back
  end

  private

  def add_shadowers_to_segments
    new_shadower_ids = []
    user_experience_params = params['experience']['user_experiences_attributes']
    if user_experience_params
      user_experience_params.each do |user_exp_params|
        new_shadower_ids << user_exp_params[1]['user_id']
      end
    end
    @experience.add_shadowers_to_all_segments(new_shadower_ids)
  end

  def experience_params
    params.require(:experience).permit(:organization_id, :name, :description, :location, :published, :created_by_id,
      user_experiences_attributes: [
        :id, :user_id, :experience_id
      ]
    )
  end

end