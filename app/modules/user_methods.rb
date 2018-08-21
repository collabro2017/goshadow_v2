module UserMethods

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def link_to_organizations(invite)
    organization_linker = OrganizationLinker.new(self, invite)
    organization_linker.find_invites
    organization_linker.give_access
  end

  def shadowing_coordinator?(organization)
    user_organizations.find_by(organization_id: organization.id).role == UserOrganization::COORDINATOR
  end

  def accessible_org_experiences(organization, is_coordinator)
    if is_coordinator
      organization.experiences.where(archived: false)
    else
      self.experiences.where(organization_id: organization.id, archived: false)
    end
  end

  def accessible_segments(experience, is_coordinator)
    if is_coordinator
      segments = experience.segments.where(archived: false)
      SegmentSorter.run(segments)
    else
      segments = self.segments.where(experience_id: experience.id, archived: false)
      SegmentSorter.run(segments)
    end
  end

  def avatar_url
    return self.avatar.attachment.url(:medium) unless ( !self.avatar.id? rescue true )
    return "default_avatar.svg"
  end

  def add_to_segment(segment)
    UserSegment.find_or_create_by(user: self, segment: segment)
    UserExperience.find_or_create_by(experience: segment.experience, user: self)
  end

  def add_to_experience(experience)
    UserExperience.find_or_create_by(experience: experience, user: self)
  end

  def org_role(org)
    user_organizations.find_by(organization_id: org.id).role
  end

end