require 'faker'

FactoryGirl.define do
	factory :images do |f|
		f.picture { Faker::Avatar.image }
	end
end