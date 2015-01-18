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

department1 = Department.create!(name: "wet end", description: "random words")
area1 = Area.create!(name: "modul facer", description: "more random words")
da1 = DepartmentArea.create!(department_id: department1.id, area_id: area1.id, name: "wet end modal facer")


impact1 = Impact.create!(name: "Downtime", description: "issues that cause downtime, ie anytime the machine could stop")
impact2 = Impact.create!(name: "Waste", description: "Waste is the result of this issuedd")

user = User.create!(name: "mya", title: "random", email: "viewer@testing.com", password: "helloworld", password_confirmation: "helloworld")
user.roles << viewers = Role.create!(:name => "Viewer")
author = User.create!(name: "second", title: "another", :email => "new_user_chad@testing.com", :password => "helloworld", :password_confirmation => "helloworld")
author.roles << authors = Role.create!(:name => "Author")
admin = User.create!(name: "thrid", title: "anther title", email: "admin@testing.com", password: "helloworld", password_confirmation: "helloworld")
admin.roles << admins = Role.create!(name: "Admin")

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

(1..10).each do
	Issue.create!(name: Faker::Lorem.sentence, 
				  description: Faker::Lorem.paragraph, 
				  review_date: Faker::Date.forward(rand(20)),
				  impact_id: impact1.id,
				  user_id: admin.id,
				  department_area_id: da1.id,
				  state: states.sample
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


