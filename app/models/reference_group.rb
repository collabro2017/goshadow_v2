class ReferenceGroup < ActiveRecord::Base

  belongs_to :group
  belongs_to :reference
  
  validates :reference_id, :group_id, presence: true
  validates :reference_id, uniqueness: { scope: :group_id }

end