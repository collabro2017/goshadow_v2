module ExperienceMethods

  def init_user_experiences
    initiated_user_eperiences = []
    organization_users.each do |user|
      if !UserExperience.find_by(user_id: user.id, experience_id: self.id)
        initiated_user_eperiences << UserExperience.new(user_id: user.id, experience_id: self.id)
      end
    end
    initiated_user_eperiences
  end

  def remove_user(user_id)
    UserExperience.find_by(user_id: user_id, experience_id: self.id).destroy
    UserSegment.where(user_id: user_id, segment_id: self.segments.pluck(:id) ).destroy_all
  end

  def organization_users
    self.organization.users
  end

  def shadower_count
    self.users.count
  end

  def segment_count(user, is_coordinator)
    if is_coordinator
      self.segments.count
    else
      user.segments.where(id: self.segments).count
    end
  end

  def add_shadowers_to_all_segments(user_ids)
    self.segments.each do |segment|
      user_ids.each do |user_id|
        UserSegment.find_or_create_by(user_id: user_id, segment_id: segment.id)
      end
    end
  end

  def reports_count
    self.reports.count
  end

  def notes
    Note.where(segment: self.segments).where.not(text: nil)
  end

  def references
    Note.where(segment: self.segments).where(text: nil)
  end

  def flow_map_sorted
    self.segments.where.not(sort_order: nil) + self.segments.where(sort_order: nil).sort_by(&:created_at)
  end

end