require 'faker'

FactoryGirl.define do
	factory :user do
		name { Faker::Name.name }
		title { Faker::Lorem.word }
		email {Faker::Internet.email}
		password 'secret_word'
		password_confirmation 'secret_word'
	end
end