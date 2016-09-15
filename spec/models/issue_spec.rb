require 'rails_helper'

RSpec.describe Issue, type: :model do
	subject { FactoryGirl.build(:issue) }
	describe "attributes" do
		it "is valid with valid attributes" do
			expect(subject).to be_valid
		end
	end
	describe "validations" do
		it { should validate_presence_of(:name).with_message('Issue needs to have a name') }
		it { should validate_presence_of(:review_date) }
		it { should validate_numericality_of(:impact_id).with_message('Impact ID must be an integer only') }
		it { should validate_numericality_of(:user_id).with_message('User ID must be an integer only') }
		it { should validate_numericality_of(:department_area_id).with_message('Department Area ID must be an integer only') }
	end
	describe "associations" do
		it { should have_many :solutions }
		it { should have_many :attempted_solutions }
		it { should have_many :issue_workarounds }
		it { should have_many :detailed_steps }
		it { should have_many :records }
		it { should have_many :notes }
		it { should belong_to :department_area }
		it { should belong_to :impact }
		it { should belong_to :user }

	end

	# test instance methods
	describe "instance_methods" do
		it "should have a method called search" do
			# this should be a feature test ??
		end
	end

	# test class methods and scopes
	describe "class methods" do
	  context "testing state machine" do
			subject { FactoryGirl.build(:issue) }
				it "should have a starting state called draft" do
					expect(subject.state).to eq "draft"
				end
		  	it "state should not be able to be set to 'publish'" do
		  		expect(subject.review_to_publish).to be false
		  		expect(subject.state).to_not be eq 'publish'
		  	end
		  	context "once state is set to review" do
		  		before { subject.draft_to_review }
		  		it "state should be equal to 'review'" do
			  		expect(subject.state).to be == "review"
			  	end
			  	it "state should be able to be changed to 'draft'" do
			  		expect(subject.review_to_draft).to be true
			  		expect(subject.state).to be == "draft"
			  	end
			  	it "state should be able to change to 'draft' with the shortcut method" do
					subject.change_state
			  		expect(subject.state).to be == "draft"
			  	end
		  		context "state should be able to be changed to 'publish'" do
		  			before { subject.review_to_publish }
		  			it "should be equal to 'publish'" do
			  			expect(subject.state).to be == "publish"
			  		end
			  		it "should be able to set to review" do
			  			expect(subject.publish_to_review).to be true
			  			expect(subject.state).to be == "review"
			  		end
			  		it "should be able to be set to draft" do
			  			expect(subject.publish_to_draft).to be true
			  			expect(subject.state).to be == "draft"
			  		end
			  		it "should be able to change the state to 'draft' with the shortcut method" do
			  			subject.change_state
			  			expect(subject.state).to be == "draft"
			  		end
		  		end
		  	end
  	end
  	it "should return the department name" do
  		
  		dep = Department.new(name: 'department', description: 'hello')
  		area = Area.new(name: 'area', description: 'hello')
  		dep_area = DepartmentArea.create(department_id: dep.id, area_id: area.id, name: "department area")
  		issue = FactoryGirl.create(:issue, department_area_id: dep_area.id)

  		expect(issue.get_department_name).to eq "department area"
  	end
  	it "should return the impact name" do
  		im = Impact.create!(name: "name", description: "description")
  		issue = FactoryGirl.create(:issue, impact_id: im.id)

  		expect(issue.get_impact_name).to eq "name"
  	end
	end


	describe "scopes" do
		it "should return the issues in decending order of created date" do
			a = Issue.create(name: "first", review_date: DateTime.now, created_at: DateTime.now - 2.weeks)
			b = Issue.create(name: "second", review_date: DateTime.now, created_at: DateTime.now - 1.weeks)
			c = Issue.create(name: "third", review_date: DateTime.now, created_at: DateTime.now)

			expect(Issue.ordered_by_desc).to eq([c,b,a])
		end
	end

	describe "constants" do
		it "should have a constant called 'per_page' to be equal to 5" do
			expect(Issue::per_page).to eq(5)
		end
		it "should have an array 'TYPES' with set values" do
			expect(Issue::TYPES).to eq(['operational', 'mechanical', 'electrical'])
		end
	end
end