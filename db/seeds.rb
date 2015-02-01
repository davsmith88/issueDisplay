# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# #
# # Examples:
# #
# #   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# #   Mayor.create(name: 'Emanuel', city: cities.first)

# Seed data for web app useful for getting up and running very quickly


User.destroy_all
Role.destroy_all
Right.destroy_all
Grant.destroy_all
Assignment.destroy_all
Department.destroy_all
Area.destroy_all
DepartmentArea.destroy_all
Impact.destroy_all
Issue.destroy_all
Business.destroy_all

business1 = Business.create!(name: "My Business", description: "Makes boxes for people")
business2 = Business.create!(name: "The second business", description: "Makes plastic widgets for other companies")

department1 = Department.create!(name: "wet end", description: "random words", business_id: business1.id)
area1 = Area.create!(name: "modul facer", description: "more random words", business_id: business1.id)
da1 = DepartmentArea.create!(department_id: department1.id, area_id: area1.id, name: "wet end modal facer", business_id: business1.id)

department2 = Department.create!(name: "dry end", description: "random", business_id: business2.id)
area2 = Area.create!(name: "stackers", description: "more", business_id: business2.id)
da2 = DepartmentArea.create!(department_id: department2.id, area_id: area2.id, name: "dry end stackers", business_id: business2.id)

department3 = Department.create!(name: "dry end", description: "qaz", business_id: business1.id)
area3 = Area.create!(name: "chop knife", description: "part of the machine that cuts board to the desired length", business_id: business1.id)
da3 = DepartmentArea.create!(department_id: department3.id, area_id: area3.id, name: "dry end chop knife", business_id: business1.id)



impact1 = Impact.create!(name: "Downtime", description: "issues that cause downtime, ie anytime the machine could stop", business_id: business1.id)
impact2 = Impact.create!(name: "Waste", description: "Waste is the result of this issuedd", business_id: business1.id)
impact3 = Impact.create!(name: "Dowtime", description: "qwerty", business_id: business2.id)
impact4 = Impact.create!(name: "Quality", description: "ww", business_id: business2.id)

user = User.create!(name: "mya", title: "random", email: "viewer@testing.com", password: "helloworld", password_confirmation: "helloworld", business_id: business1.id)
viewers = business1.roles.create!(:name => "Viewer")
Assignment.create!(role_id: viewers.id, user_id: user.id, business_id: business1.id)
# user.roles << viewers = business1.roles.create!(:name => "Viewer")
author = User.create!(name: "second", title: "another", :email => "new_user_chad@testing.com", :password => "helloworld", :password_confirmation => "helloworld", business_id: business1.id)
authors = business1.roles.create!(:name => "Author")
Assignment.create!(role_id: authors.id, user_id: author.id, business_id: business1.id)
# author.roles << authors = business1.roles.create!(:name => "Author")
admin = User.create!(name: "thrid", title: "anther title", email: "admin@testing.com", password: "helloworld", password_confirmation: "helloworld", business_id: business1.id)
admins = business1.roles.create!(name: "Admin")
Assignment.create!(role_id: admins.id, user_id: admin.id, business_id: business1.id)
# admin.roles << admins = business1.roles.create!(name: "Admin")



user1 = User.create!(name: "mya", title: "random", email: "viewer2@testing.com", password: "helloworld", password_confirmation: "helloworld", business_id: business2.id)
viewers = business2.roles.create!(:name => "Viewer")
Assignment.create!(user_id: user1.id, role_id: viewers.id, business_id: business2.id)
# user1.roles << viewers = business2.roles.create!(:name => "Viewer")
author1 = User.create!(name: "second", title: "another", :email => "new_user_chad2@testing.com", :password => "helloworld", :password_confirmation => "helloworld", business_id: business2.id)
authors = business2.roles.create!(:name => "Author")
Assignment.create!(user_id: author1.id, role_id: authors.id, business_id: business2.id)
# author1.roles << authors = business2.roles.create!(:name => "Author")
admin1 = User.create!(name: "thrid", title: "anther title", email: "admin2@testing.com", password: "helloworld", password_confirmation: "helloworld", business_id: business2.id)
admins = business2.roles.create!(name: "Admin")
Assignment.create!(user_id: admin1.id, role_id: admins.id, business_id: business2.id)
# admin1.roles << admins = business2.roles.create!(name: "Admin")



create = Right.create!(:resource => "issues", :operation => "CREATE")
read = Right.create!(:resource => "issues", :operation => "READ")
update = Right.create!(:resource => "issues", :operation => "UPDATE")
delete = Right.create!(:resource => "issues", :operation => "DELETE")
admins.rights << read
admins.rights << delete
admins.rights << create
admins.rights << update
admin_read = Right.create!(:resource => "admin", :operation => "READ")

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
	business = business_array.sample
	Issue.create!(name: Faker::Lorem.sentence, 
				  description: Faker::Lorem.paragraph, 
				  review_date: Faker::Date.forward(rand(20)),
				  impact_id: business[:impacts].sample.id,
				  user_id: admin.id,
				  department_area_id: business[:das].sample.id,
				  state: states.sample,
				  business_id: business[:business].id
				 )
end


resources = ["impacts", 
			 "assignments", 
			 "grants", 
			 "issue_management", 
			 "department_areas", 
			 "departments", 
			 "areas", 
			 "roles", 
			 "rights",
			 "issue_workarounds",
			 "solutions",
			 "attempted_solutions",
			 "images",
			 "users"]

operations = ["READ", "CREATE", "UPDATE", "DELETE"]

resources.each do |resource|
	operations.each do |operation|
		admins.rights << Right.create!(resource: resource, operation: operation)
	end
end

admins.rights << admin_read

viewers.rights << read

authors.rights << create
authors.rights << read
authors.rights << update
authors.rights << delete


