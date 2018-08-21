class ReferenceSegment < ActiveRecord::Base
  
  belongs_to :segment
  belongs_to :reference
    
  validates :reference_id, :segment_id, presence: true
  validates :reference_id, uniqueness: { scope: :segment_id }

end