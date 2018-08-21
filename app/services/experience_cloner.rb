class ExperienceCloner

  def initialize(experience)
    @experience = experience
    @new_experience = nil
  end

  def run
    copy_experience
    copy_users
    copy_segments
  end

  def copy_experience
    @new_experience = @experience.dup
    @new_experience.update(name: ( @experience.name + '( cloned version ) ') )
  end

  def copy_users
    @experience.users.each { |user| UserExperience.find_or_create_by(experience_id: @new_experience.id, user_id: user.id) }
  end

  def copy_segments
    @experience.segments.each do |segment|
      segment_cloner = SegmentCloner.new(@new_experience, segment)
      segment_cloner.run
    end
  end

end