class SearchesController < ApplicationController

  def experiences
    @organization = Organization.find(params['organization_id'])
    @experiences = @organization.search_experiences(params['search_term']).paginate(page: params[:page])
    @experience = @organization.experiences.build
    render layout: 'organization', template: 'organizations/experiences'
  end

  def shadowers
    @organization = Organization.find(params['organization_id'])
    @user_organizations = @organization.search_shadowers(params['search_term'])
    @invites = @organization.search_invites(params['search_term'])
    @invite = Invite.new
    render layout: 'organization', template: 'organizations/shadowers'
  end

  def persons
    @organization = Organization.find(params['organization_id'])
    @persons = @organization.search_persons(params['search_term'])
    @person_groups = @organization.person_groups
    @new_person = Person.new
    render layout: 'organization', template: 'organizations/persons'
  end

  def places
    @organization = Organization.find(params['organization_id'])
    @places = @organization.search_places(params['search_term'])
    @place_groups = @organization.place_groups
    @new_place = Place.new
    render layout: 'organization', template: 'organizations/places'
  end

  def organizations
    search_term = params['search_term']
    @organizations = Organization.where("lower(name) LIKE ?", "%#{search_term.downcase}%")
    render template: 'admin/index'
  end

end