class Group < ActiveRecord::Base

  belongs_to :organization

  has_many :reference_groups, dependent: :destroy
  has_many :references, through: :reference_groups
  
  validates :organization_id, :name, presence: true
  validates :name, uniqueness: { scope: [ :organization_id, :type ] }

  default_scope { order('lower(name) ASC') }
  
end