class User < ActiveRecord::Base

	has_many :assignments
	has_many :roles, :through => :assignments
  has_many :issues
  
  belongs_to :business

  validates :name, presence: {message: "Name needs to be supplied"}
  validates :title, presence: {message: "Title needs to be supplied"}
  validates :email, presence: {message: "User needs to supply an email address"}

  self.per_page = 5

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def can?(action, resource)
  	puts "#{action} #{resource}"
  	roles.includes(:rights).for(action, resource).references(:rights).any?
  end
end
