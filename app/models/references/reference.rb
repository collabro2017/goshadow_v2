class Reference < ActiveRecord::Base

  has_many :notes, dependent: :destroy
  belongs_to :organization

  validates :name, uniqueness: { scope: [ :organization_id, :type ] }
  validates :name, :organization, :type, :created_by_id, presence: true

  default_scope { order('lower(name) ASC') }
  
end