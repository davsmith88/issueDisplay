require 'faker'

FactoryGirl.define do
	factory :business do
		name { Faker::Name.name }
		location { Faker::Lorem.word }
		description { Faker::Lorem.sentence }
	end
end