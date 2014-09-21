class User < ActiveRecord::Base

	has_many :assignments
	has_many :roles, :through => :assignments
  has_many :issues

  self.per_page = 3

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def can?(action, resource)
  	# puts "#{action} #{resource}"
  	roles.includes(:rights).for(action, resource).references(:rights).any?
  end
end
