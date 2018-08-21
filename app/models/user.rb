class User < ActiveRecord::Base
  
  include UserMethods
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :avatar, as: :assetable, class_name: 'Avatar', dependent: :destroy

  has_many :user_organizations, dependent: :destroy, inverse_of: :user
  has_many :organizations, through: :user_organizations
  
  has_many :user_experiences, dependent: :destroy, inverse_of: :user
  has_many :experiences, through: :user_experiences

  has_many :user_segments, dependent: :destroy, inverse_of: :user
  has_many :segments, through: :user_segments

  validates :first_name, :last_name, :email, presence: true

  accepts_nested_attributes_for :user_organizations
  accepts_nested_attributes_for :avatar, reject_if: proc { |attribute| attribute['attachment'].blank? } 

  default_scope { order('last_name') }

end