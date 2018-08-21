class UserExperience < ActiveRecord::Base

  belongs_to :user  
  belongs_to :experience
  
  validates :user, :experience, presence: true
  validates :user_id, uniqueness: { scope: :experience_id, message: 'has already been added.' }
  
  after_create :notify_user

  def notify_user
    if self.experience.created_by_id != self.user_id
      InviteShadowerMailer.new_experience(self.user, self.experience).deliver
    end
  end

end