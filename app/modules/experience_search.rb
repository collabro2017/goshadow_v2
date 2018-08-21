module ExperienceSearch

  def search_experiences(search_term)
    self.experiences.where("lower(name) LIKE ? OR lower(description) LIKE ?", "%#{search_term.downcase}%", "%#{search_term.downcase}%")
  end

end

