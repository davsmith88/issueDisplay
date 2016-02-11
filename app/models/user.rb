class User < ActiveRecord::Base

	# has_many :assignments
	# has_many :roles, :through => :assignments
  has_many :issues
  
  belongs_to :business

  # validates :name, presence: {message: "Name needs to be supplied"}
  # validates :title, presence: {message: "Title needs to be supplied"}
  validates :email, presence: {message: "User needs to supply an email address"}

  self.per_page = 5

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Roles must be in order from lowest precedance to the highest
  ROLES = %w[user creator admin beta godmode]
  
  def role?(base_role)
    # this function checks to see of a user has a role
    # if the index of the role to check is lower than the role the user has,
    # then the user is granted access to the resource
    ROLES.index(base_role.to_s) <= ROLES.index(permType)
  end
end
