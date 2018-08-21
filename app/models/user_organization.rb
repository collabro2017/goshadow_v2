class UserOrganization < ActiveRecord::Base

  belongs_to :user
  belongs_to :organization

  validates :user, :organization, :role, presence: true
  validates :user_id, uniqueness: { scope: :organization_id }

  accepts_nested_attributes_for :organization

  COORDINATOR = 'Coordinator'
  SHADOWER = 'Shadower'

end