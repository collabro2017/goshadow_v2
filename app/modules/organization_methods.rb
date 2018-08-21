module OrganizationMethods

  def remaining_trial_time
    trial_end = self.created_at.to_date + 30.days
    days_remaining = (trial_end - Date.today).to_i
  end

  def subscription_plan_name
    if self.stripe_plan_id == '1'
      'Solo License'
    elsif self.stripe_plan_id == '2'
      'Team (10 Licenses)'
    elsif self.stripe_plan_id == '3'
      'Facility (25 Licenses)'
    else
      'Not Subscribed'
    end
  end

  def license_status
    user_count = self.users.count
    license_count = Organization::LICENSE_KEY[self.stripe_plan_id][:license_count]
    "#{user_count}/#{license_count} Shadowers"
  end

  def remove_shadower(user_id)
    org_experiences = self.experiences
    org_segments = Segment.where(experience: org_experiences)
    self.user_organizations.where(user_id: user_id).destroy_all
    UserExperience.where(user_id: user_id, experience_id: org_experiences ).destroy_all
    UserSegment.where(user_id: user_id, segment_id: org_segments).destroy_all
  end

  def save_user_activity(user)
    if !user.system_admin && ( self.last_activity_time < ( Time.now - 5.minutes ) rescue true )
      self.update(last_activity_user_id: self.id, last_activity_time: DateTime.now)
    end
  end

  def logo_url
    return self.organization_logo.attachment.url(:medium) unless ( !self.organization_logo.id? rescue true )
    return "default_org_avatar.svg"
  end

end