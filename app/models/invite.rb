class Invite < ActiveRecord::Base
  
  include InviteMethods

  belongs_to :invited_by, class_name: 'User'
  belongs_to :organization
  belongs_to :experience

  validates :organization_id, :invited_by_id, :name, :email, :token, :organization_role, presence: true
  validates :email, email: true

  default_scope { order('created_at DESC') }

 end