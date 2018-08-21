class UserSegment < ActiveRecord::Base

  belongs_to :user
  belongs_to :segment

  validates :user, :segment, presence: true
  validates :user_id, uniqueness: { scope: :segment_id }

end