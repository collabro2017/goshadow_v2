class Note < ActiveRecord::Base

  include NoteMethods
  
  belongs_to :segment
  belongs_to :reference
  belongs_to :user

  has_one :note_image, as: :assetable, class_name: 'NoteImage', dependent: :destroy

  validates :segment_id, presence: true
  
  default_scope { order('created_at ASC') }
  
  NEGATIVE_STATUS = 'Negative'
  POSITIVE_STATUS = 'Positive'

  def duration
    seconds ? "#{Time.at(seconds).utc.strftime("%H:%M:%S")}" : "00:00:00"
  end
  
end