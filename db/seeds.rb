# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# #
# # Examples:
# #
# #   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# #   Mayor.create(name: 'Emanuel', city: cities.first)

# Seed data for web app useful for getting up and running very quickly

User.destroy_all

# Assignment.destroy_all
# Role.destroy_all
# Right.destroy_all
# Grant.destroy_all
# Assignment.destroy_all

Department.destroy_all
Area.destroy_all
DepartmentArea.destroy_all
Impact.destroy_all
Issue.destroy_all
Step.destroy_all
Business.destroy_all

# Business
# ---------

business1 = Business.create!(name: "My Business", description: "Makes boxes for people")
business2 = Business.create!(name: "The second business", description: "Makes plastic widgets for other companies")

# Users
# -------

user = User.create!(name: "User", title: "random", email: "viewer@testing.com", 
		password: "helloworld", password_confirmation: "helloworld", 
		business_id: business1.id, permType: "user")
author = User.create!(name: "Author User", title: "another", email: "author@testing.com", 
		:password => "helloworld", :password_confirmation => "helloworld", 
		business_id: business1.id, permType: "creator")
admin = User.create!(name: "My Admin User", title: "another", email: "admin@testing.com", 
		:password => "helloworld", :password_confirmation => "helloworld", 
		business_id: business1.id, permType: "admin")

# Departments/Area's
# ----------------

	# - Departments
	# --------	
	department1 = Department.create!(name: "wet end", description: "random words", business_id: business1.id)
	department2 = Department.create!(name: "dry end", description: "random", business_id: business2.id)
	department3 = Department.create!(name: "dry end", description: "qaz", business_id: business1.id)
	department4 = Department.create!(name: "BHS", description: "BHS", business_id: business1.id)

	# - Area's
	# ---------
	area1 = Area.create!(name: "modul facer", description: "more random words", business_id: business1.id)
	area2 = Area.create!(name: "stackers", description: "more", business_id: business2.id)
	area3 = Area.create!(name: "chop knife", description: "part of the machine that cuts board to the desired length", business_id: business1.id)
	area4 = Area.create!(name: "SRA", description: "SRA", business_id: business1.id)
	area5 = Area.create!(name: "AAR3", description: "AAR3", business_id: business1.id)



	# - Departments and Areas
	# ---------------
	da1 = DepartmentArea.create!(department_id: department1.id, area_id: area1.id, name: "wet end modal facer", business_id: business1.id)
	da2 = DepartmentArea.create!(department_id: department2.id, area_id: area2.id, name: "dry end stackers", business_id: business2.id)
	da3 = DepartmentArea.create!(department_id: department3.id, area_id: area3.id, name: "dry end chop knife", business_id: business1.id)
	da4 = DepartmentArea.create!(department_id: department4.id, area_id: area4.id, name: "BHS SRA")
	da5 = DepartmentArea.create!(department_id: department4.id, area_id: area5.id, name: "BHS AAR3")

# Impacts
# ----------

impact1 = Impact.create!(name: "Downtime", description: "issues that cause downtime, ie anytime the machine could stop", business_id: business1.id)
impact2 = Impact.create!(name: "Waste", description: "Waste is the result of this issue", business_id: business1.id)
impact5 = Impact.create!(name: "Machine Setup", description: "Machine setup has downtime, but neccessary for machine to start", business_id: business1.id)
impact3 = Impact.create!(name: "Dowtime", description: "qwerty", business_id: business2.id)
impact4 = Impact.create!(name: "Quality", description: "ww", business_id: business2.id)

# Issues
# -------

states = ["draft", "review", "publish"]
business_array = [{business: business1,
				  impacts: [impact1, impact2],
				  departments: [department1, department3],
				  areas: [area1, area3],
				  das: [da1, da3]}, 
				  {business: business2,
				  impacts: [impact3, impact4],
				  departments: [department2],
				  areas: [area2],
				  das: [da2]}]

impacts_array = [impact1, impact2]

(1..10).each do
	puts "issue created"
	business = business_array[1]
	Issue.create!(name: Faker::Lorem.sentence,
				  description: Faker::Lorem.paragraph, 
				  review_date: Faker::Date.forward(rand(20)),
				  impact_id: business[:impacts].sample.id,
				  user_id: admin.id,
				  department_area_id: business[:das].sample.id,
				  state: states.sample,
				  business_id: business1.id
				 )
end

Issue.create!(name: "Referencing Slitters",
			  description: "This issues shows the user how to reference the slitter",
			  review_date: Faker::Date.forward(rand(20)),
			  impact_id: impact4.id,
			  user_id: author.id,
			  department_area_id: da4.id,
			  state: "publish",
			  business_id: business1.id
			  )

Issue.create!(name: "Referencing Stackers",
			  description: "Every time the power is shut down, the stackers have to be referenced",
			  review_date: Faker::Date.forward(rand(20)),
			  impact_id: impact5.id,
			  user_id: author.id,
			  department_area_id: da5.id,
			  state: "publish",
			  business_id: business1.id
			  )


# resources = ["impacts", 
# 			 "assignments", 
# 			 "grants", 
# 			 "issue_management", 
# 			 "department_areas", 
# 			 "departments", 
# 			 "areas", 
# 			 "roles", 
# 			 "rights",
# 			 "issue_workarounds",
# 			 "solutions",
# 			 "attempted_solutions",
# 			 "images",
# 			 "users", 
# 			 "business",
# 			 "admin_business",
# 			 "issues"]

# operations = ["READ", "CREATE", "UPDATE", "DESTROY"]

# resources.each do |resource|
# 	operations.each do |operation|
# 		puts "----"
# 		puts "#{admins}"
# 		puts "#{resource} #{operation}"
# 		admins.rights << Right.create!(resource: resource, operation: operation)
# 	end
# end

# admins.rights.each do |right|
# 	Grant.create(right_id: right.id, role_id: admins.id)
# end
# admin_read = Right.create!(:resource => "admin", :operation => "READ")

# admins.rights << admin_read





# viewers.rights << read

# authors.rights << create
# authors.rights << read
# authors.rights << update
# authors.rights << delete


