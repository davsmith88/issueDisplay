class Business < ActiveRecord::Base
	has_many :issues
	has_many :users
	has_many :impacts

	has_many :areas
	has_many :departments
	has_many :department_areas

	has_many :roles
	has_many :assignments
end
