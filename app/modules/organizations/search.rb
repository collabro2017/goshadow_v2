module Organizations
  module Search

    def search_experiences(search_term)
      self.experiences.where("lower(name) LIKE ? OR lower(description) LIKE ?", "%#{search_term.downcase}%", "%#{search_term.downcase}%")
    end

    def search_shadowers(search_term)
      users = self.users.where(
        "lower(first_name) LIKE ? OR lower(last_name) LIKE ? OR lower(email) LIKE ?", "%#{search_term.downcase}%", "%#{search_term.downcase}%", "%#{search_term.downcase}%"
      )
      self.user_organizations.where(user_id: users.pluck(:id))
    end

    def search_invites(search_term)
      self.invites.where("lower(name) LIKE ? OR lower(email) LIKE ?", "%#{search_term.downcase}%", "%#{search_term.downcase}%")
    end

    def search_persons(search_term)
      self.persons.where("lower(name) LIKE ?", "%#{search_term.downcase}%")
    end

    def search_places(search_term)
      self.places.where("lower(name) LIKE ?", "%#{search_term.downcase}%")
    end

  end
end