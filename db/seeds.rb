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

department1 = Department.create!(name: "wet end", description: "random words")
area1 = Area.create!(name: "modul facer", description: "more random words")
DepartmentArea.create!(department_id: department1.id, area_id: area1.id, name: "wet end modal facer")


Impact.create!(name: "Downtime", description: "issues that cause downtime, ie anytime the machine could stop")
Impact.create!(name: "Waste", description: "Waste is the result of this issue")

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
admins.rights << Right.create!(resource: "roles", operation: "READ")
admins.rights << Right.create!(resource: "roles", operation: "CREATE")
admins.rights << Right.create!(resource: "roles", operation: "UPDATE")
admins.rights << Right.create!(resource: "roles", operation: "DELETE")

admins.rights << Right.create!(resource: "rights", operation: "READ")
admins.rights << Right.create!(resource: "rights", operation: "CREATE")
admins.rights << Right.create!(resource: "rights", operation: "UPDATE")
admins.rights << Right.create!(resource: "rights", operation: "DELETE")

admins.rights << Right.create!(resource: "areas", operation: "READ")
admins.rights << Right.create!(resource: "areas", operation: "CREATE")
admins.rights << Right.create!(resource: "areas", operation: "UPDATE")
admins.rights << Right.create!(resource: "areas", operation: "DELETE")

admins.rights << Right.create!(resource: "departments", operation: "READ")
admins.rights << Right.create!(resource: "departments", operation: "CREATE")
admins.rights << Right.create!(resource: "departments", operation: "UPDATE")
admins.rights << Right.create!(resource: "departments", operation: "DELETE")

admins.rights << Right.create!(resource: "department_areas", operation: "READ")
admins.rights << Right.create!(resource: "department_areas", operation: "CREATE")
admins.rights << Right.create!(resource: "department_areas", operation: "UPDATE")
admins.rights << Right.create!(resource: "department_areas", operation: "DELETE")

admins.rights << Right.create!(resource: "issue_management", operation: "READ")

admins.rights << admin_read

viewers.rights << read

authors.rights << create
authors.rights << read
authors.rights << update
authors.rights << delete


