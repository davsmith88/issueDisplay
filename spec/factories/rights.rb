require 'faker'
FactoryGirl.define do
	factory :right do
		resource { Faker::Lorem.word }
		operation { Faker::Lorem.word }
	end

	factory :grant do
		association :right
		association :role
	end
	factory :role do
		name { Faker::Lorem.word }
		description { Faker::Lorem.sentence }
	end
	factory :assignment do
		association :user
		association :role
	end
end