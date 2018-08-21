class Organization < ActiveRecord::Base

  include Organizations::Search
  include OrganizationMethods
  include OrganizationSubscriptionMethods
  
  has_many :experiences, dependent: :destroy
  has_many :user_organizations, dependent: :destroy, inverse_of: :organization
  has_many :users, through: :user_organizations
  has_many :invites, dependent: :destroy
  has_many :references, dependent: :destroy
  has_many :persons, dependent: :destroy
  has_many :places, dependent: :destroy
  has_many :place_groups, dependent: :destroy
  has_many :person_groups, dependent: :destroy
  has_one :organization_logo, as: :assetable, class_name: 'OrganizationLogo', dependent: :destroy
  
  validates :name, presence: true

  SMALL = { max_users: 1, text_description: '1 person', table_key: 'small'}
  MEDIUM = { max_users: 10, text_description: '2-10 People', table_key: 'medium' }
  LARGE = { max_users: 25, text_description: '11-25 People', table_key: 'large' }
  XTRA_LARGE = { max_users: 100000, text_description: '26+ People', table_key: 'extra_large' }

  TEAM_SIZES = [ SMALL, MEDIUM, LARGE, XTRA_LARGE ]

  LICENSE_KEY = { '1' => { license_count: 1 }, '2' => { license_count: 10 }, '3' => { license_count: 25 } }

  accepts_nested_attributes_for :organization_logo, reject_if: proc { |attribute| attribute['attachment'].blank? }

  default_scope { order('name') }

end