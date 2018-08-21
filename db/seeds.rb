# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.create(first_name: 'Joe', last_name: 'Shadower', password: 'goshadow', password_confirmation: 'goshadow', email: 'joeshadower@goshadow.com')
user2 = User.create(first_name: 'Angela', last_name: 'DeVanney', password: 'goshadow', password_confirmation: 'goshadow', email: 'angela@goshadow.org')
user3 = User.create(first_name: 'Molly', last_name: 'OBrien', password: 'goshadow', password_confirmation: 'goshadow', email: 'molly@goshadow.org')
user4 = User.create(first_name: 'Cameron', last_name: 'Scott', password: 'goshadow', password_confirmation: 'goshadow', email: 'cscott@inquiri.com')
user5 = User.create(first_name: 'Steve', last_name: 'Danko', password: 'goshadow', password_confirmation: 'goshadow', email: 'sdanko@inquiri.com')

inquiri = Organization.create(name: 'Inquiri', team_size: Organization::SMALL[:table_key])
goshadow = Organization.create(name: 'Goshadow', team_size: Organization::SMALL[:table_key])

UserOrganization.create(user_id: user1.id, organization_id: goshadow.id, role: UserOrganization::COORDINATOR)
UserOrganization.create(user_id: user2.id, organization_id: goshadow.id, role: UserOrganization::COORDINATOR)
UserOrganization.create(user_id: user3.id, organization_id: goshadow.id, role: UserOrganization::COORDINATOR)
UserOrganization.create(user_id: user4.id, organization_id: goshadow.id, role: UserOrganization::COORDINATOR)
UserOrganization.create(user_id: user5.id, organization_id: goshadow.id, role: UserOrganization::COORDINATOR)
UserOrganization.create(user_id: user1.id, organization_id: inquiri.id, role: UserOrganization::COORDINATOR)
UserOrganization.create(user_id: user2.id, organization_id: inquiri.id, role: UserOrganization::COORDINATOR)
UserOrganization.create(user_id: user3.id, organization_id: inquiri.id, role: UserOrganization::COORDINATOR)
UserOrganization.create(user_id: user4.id, organization_id: inquiri.id, role: UserOrganization::COORDINATOR)
UserOrganization.create(user_id: user5.id, organization_id: inquiri.id, role: UserOrganization::COORDINATOR)

Organization.all.each do |org|
  person_1 = Person.create(name: 'Doctor', created_by_id: user1.id, organization_id: org.id)
  person_2 = Person.create(name: 'Janitor', created_by_id: user1.id, organization_id: org.id)
  person_3 = Person.create(name: 'Nurse', created_by_id: user1.id, organization_id: org.id)
  person_4 = Person.create(name: 'Front Desk Attendant', created_by_id: user1.id, organization_id: org.id)
  person_5 = Person.create(name: 'Parking Lot Manager', created_by_id: user1.id, organization_id: org.id)
  person_6 = Place.create(name: 'Operating Room', created_by_id: user1.id, organization_id: org.id)
  person_7 = Place.create(name: 'Conference Room', created_by_id: user1.id, organization_id: org.id)
  person_8 = Place.create(name: 'Bathroom', created_by_id: user1.id, organization_id: org.id)
  person_9 = Place.create(name: 'Hospital Lobby', created_by_id: user1.id, organization_id: org.id)
  person_10 = Place.create(name: 'Waiting Room', created_by_id: user1.id, organization_id: org.id)
end

exper_1 = Experience.create(organization_id: inquiri.id, name: 'Client Meeting with the Goshadow team.', description: 'learn about the new project', location: 'The Beauty Shoppe')
exper_2 = Experience.create(organization_id: inquiri.id, name: 'Monday Team Meeting', description: 'Review all exisiting client projects.', location: 'The Beauty Shoppe')
exper_3 = Experience.create(organization_id: inquiri.id, name: 'Walk to Lunch', description: 'Refuel and get food.', location: 'Whole Foods.')
exper_4 = Experience.create(organization_id: inquiri.id, name: 'Friday Team Drinks', description: 'The week is over relax and have a beer.', location: 'Fireside.')
exper_5 = Experience.create(organization_id: goshadow.id, name: 'Back Surgery', description: 'Administer back surgery.', location: 'UPMC Oakland.')
exper_6 = Experience.create(organization_id: goshadow.id, name: 'Clean of the Hospital Bathrooms.', description: 'Clean bathrooms.', location: 'Maghee Hospital.')
exper_7 = Experience.create(organization_id: goshadow.id, name: 'Meet with the Inquiri team.', description: 'Review the progress of the new GoShadow web app.', location: 'The Beauty Shoppe')
exper_8 = Experience.create(organization_id: goshadow.id, name: 'Angela + Molly meet to discuss marketing.', description: 'Learn about the new marketing plan.', location: 'The Beauty Shoppe')
exper_9 = Experience.create(organization_id: goshadow.id, name: 'Ordering at Starbucks', description: 'Shadowing the Starbucks experience as a customer ordering a drink ', location: 'Oakland Starbucks')

Experience.all.each do |experience|
  segment_1 = Segment.create(experience_id: experience.id, name: 'Segment 1', start_location: 'My House', end_location: 'Work')
  segment_2 = Segment.create(experience_id: experience.id, name: 'Segment 2', start_location: 'My Apartment', end_location: 'Target')
  segment_3 = Segment.create(experience_id: experience.id, name: 'Segment 3', start_location: 'Frick Park', end_location: 'The Store')
  references = Reference.where(organization_id: experience.organization.id)
  experience.segments.each do |segment|
    Note.create(segment_id: segment.id, start_time: DateTime.now - 5.days, seconds: 130, text: 'This is note text',reference_id: references.pluck(:id)[rand(references.count - 1)])
    Note.create(segment_id: segment.id, start_time: DateTime.now - 5.days, seconds: 130, text: 'This is note text',reference_id: references.pluck(:id)[rand(references.count - 1)])
    Note.create(segment_id: segment.id, start_time: DateTime.now - 5.days, seconds: 130, text: 'This is note text',reference_id: references.pluck(:id)[rand(references.count - 1)])
    Note.create(segment_id: segment.id, start_time: DateTime.now - 5.days, seconds: 130, text: 'This is note text',reference_id: references.pluck(:id)[rand(references.count - 1)])
    Note.create(segment_id: segment.id, start_time: DateTime.now - 5.days, seconds: 130, text: 'This is note text',reference_id: references.pluck(:id)[rand(references.count - 1)])
    Note.create(segment_id: segment.id, start_time: DateTime.now - 3.days, seconds: 100, reference_id: references.pluck(:id)[rand(references.count - 1)])
    Note.create(segment_id: segment.id, start_time: DateTime.now - 10.days, seconds: 200, text: 'This is a note text that is here, the note text is present.', reference_id: references.pluck(:id)[rand(references.count - 1)])
    Note.create(segment_id: segment.id, start_time: DateTime.now - 1.days, seconds: 500, reference_id: references.pluck(:id)[rand(references.count - 1)])
    Note.create(segment_id: segment.id, start_time: DateTime.now - 1.days, seconds: 500, reference_id: references.pluck(:id)[rand(references.count - 1)])
    Note.create(segment_id: segment.id, start_time: DateTime.now - 1.days, seconds: 500, reference_id: references.pluck(:id)[rand(references.count - 1)])
    Note.create(segment_id: segment.id, start_time: DateTime.now - 1.days, seconds: 500, reference_id: references.pluck(:id)[rand(references.count - 1)])
    Note.create(segment_id: segment.id, start_time: DateTime.now - 1.days, seconds: 500, reference_id: references.pluck(:id)[rand(references.count - 1)])
    Note.create(segment_id: segment.id, start_time: DateTime.now - 1.days, seconds: 500, reference_id: references.pluck(:id)[rand(references.count - 1)])
    Note.create(segment_id: segment.id, start_time: DateTime.now - 1.days, seconds: 500, reference_id: references.pluck(:id)[rand(references.count - 1)])
    Note.create(segment_id: segment.id, start_time: DateTime.now - 1.days, seconds: 500, reference_id: references.pluck(:id)[rand(references.count - 1)])
    Note.create(segment_id: segment.id, start_time: DateTime.now - 1.days, seconds: 500, reference_id: references.pluck(:id)[rand(references.count - 1)])
    Note.create(segment_id: segment.id, start_time: DateTime.now - 2.days, seconds: 100, text: 'note text', reference_id: references.pluck(:id)[rand(references.count - 1)])
    Note.create(segment_id: segment.id, start_time: DateTime.now - 8.days, seconds: 200, text: 'Notes are a pretty cool feature of the new goshadow platform.', reference_id: references.pluck(:id)[rand(references.count - 1)])
    Note.create(segment_id: segment.id, start_time: DateTime.now - 12.days, seconds: 4000, reference_id: references.pluck(:id)[rand(references.count - 1)])
  end
end