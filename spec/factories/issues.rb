require 'faker'

FactoryGirl.define do
	factory :issue do |f|
		f.name { Faker::Name.name }
		f.description { Faker::Lorem.sentence }
		f.review_date { Faker::Date.forward(10) }
		f.association :department_area, factory: :department_area
		f.association :impact, factory: :impact
		# f.user_id { rand(10) }
		
		factory :invalid_issue do |f|
			f.name nil
			f.review_date nil
		end
	end

	factory :impact do |f|
		f.name { Faker::Lorem.word}
		f.description { Faker::Lorem.sentence }
	end

	factory :department do |f|
		f.name { Faker::Lorem.word }
		f.description { Faker::Lorem.sentence }
	end

	factory :area do |f|
		f.name { Faker::Lorem.word }
		f.description { Faker::Lorem.sentence }
	end

	factory :department_area do |f|
		f.association :department
		f.association :area
		f.name { "#{area.name} #{department.name}" }
	end
end