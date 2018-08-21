class Segment < ActiveRecord::Base

  include SegmentMethods
  include ArchiveHelper
    
  belongs_to :experience
  belongs_to :created_by, class_name: 'User'
  has_many :notes, dependent: :destroy
  has_many :invites, dependent: :destroy

  has_many :reference_segments, dependent: :destroy
  has_many :references, through: :reference_segments

  has_many :user_segments, dependent: :destroy, inverse_of: :segment
  has_many :users, through: :user_segments

  validates :experience, :name, presence: true

  accepts_nested_attributes_for :user_segments, reject_if: proc { |a| a['user_id'].blank? || a['segment_id'].blank? }

  default_scope { order('sort_order, created_at') }

end