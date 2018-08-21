class Experience < ActiveRecord::Base

  include ExperienceMethods
  include ArchiveHelper
  
  belongs_to :organization
  belongs_to :created_by, class_name: 'User'

  has_many :segments, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :invites, dependent: :destroy

  has_many :user_experiences, dependent: :destroy, inverse_of: :experience
  has_many :users, through: :user_experiences

  validates :name, :organization_id, presence: true

  accepts_nested_attributes_for :user_experiences, reject_if: proc { |a| a['user_id'].blank? || a['experience_id'].blank? }

  default_scope { order('created_at DESC') }

  self.per_page = 5

end