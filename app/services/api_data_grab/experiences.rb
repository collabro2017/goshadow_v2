module ApiDataGrab
  class Experiences

    def initialize(user)
      @all_experiences = []
      @user = user
    end

    def run
      @user.organizations.each do |organization|
        get_experiences(organization)
      end
      @all_experiences
    end

    def get_experiences(organization)
      is_coordinator = @user.shadowing_coordinator?(organization)
      experiences = @user.accessible_org_experiences(organization, is_coordinator)
      experiences.each do |experience|
        experience_json = ExperienceSerializer.new(experience, scope: { user_id: @user.id, is_coordinator: is_coordinator }, root: false).to_json
        @all_experiences << JSON.parse(experience_json)
      end
    end
    
  end
end