# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Role.destroy_all
Right.destroy_all
Grant.destroy_all
Assignment.destroy_all

user = User.create!(:email => "new_user@testing.com", :password => "helloworld", :password_confirmation => "helloworld")
user.roles << viewers = Role.create!(:name => "Viewer")

author = User.create!(:email => "new_user_chad@testing.com", :password => "helloworld", :password_confirmation => "helloworld")
author.roles << authors = Role.create!(:name => "Author")

create = Right.create!(:resource => "issues", :operation => "CREATE")
read = Right.create!(:resource => "issues", :operation => "READ")
update = Right.create!(:resource => "issues", :operation => "UPDATE")
delete = Right.create!(:resource => "issues", :operation => "DELETE")

viewers.rights << read

authors.rights << create
authors.rights << read
authors.rights << update
authors.rights << delete


