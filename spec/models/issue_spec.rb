require 'spec_helper'


describe Issue do
  before { subject.valid? }
  subject { FactoryGirl.create(:issue) }

  #testing validations
  it "has a valid factory" do
  	FactoryGirl.create(:issue).should be_valid
  end

  it "is invalid without a name" do
  	FactoryGirl.build(:issue, name: nil).should_not be_valid
  end

  it "is invalid without a review date" do
  	FactoryGirl.build(:issue, review_date: nil).should_not be_valid
  end
#   #tests the attributes for the model
#   it { should respond_to(:name) }
#   it { should respond_to(:description) }
#   it { should respond_to(:review_date) }

#   # tests the associations for the model
#   it { should belong_to(:user) }
#   it { should belong_to(:impact) }
#   it { should belong_to(:department_area) }

#   it { should have_many(:solutions) }
#   it { should have_many(:issue_workarounds) }
#   it { should have_many(:attempted_solutions) }
#   it { should have_many(:notes) }
#   it { should have_many(:images) }
#   it { should have_many(:records) }

#  #  context "validations" do
#  #    context "for field impact id" do
#  #      subject { FactoryGirl.build(:issue, impact_id: "ww") }
#  #      before do
#  #        subject.valid?
#  #      end
#  #      it { should_not be_valid }
#  #      it "will have an error message in the errors hash" do
#  #        expect(subject.errors.messages[:impact_id]).to include("Impact ID must be an integer only")
#  #      end
#  #    end
#  #    context "for user id" do
#  #      subject { FactoryGirl.build(:issue, user_id: "were") }
#  #      it "only accept whole integers" do
#  #        subject.valid?
#  #        expect(subject).to_not be_valid
#  #      end
#  #      it "on error will have a custom error message" do
#  #        subject.valid?
#  #        expect(subject.errors.messages[:user_id]).to include("User ID must be an integer only")
#  #      end
#  #    end
#  #    context "for department area id" do
#  #      subject { FactoryGirl.build(:issue, department_area_id: "were") }
#  #      it "only accept whole integers" do
#  #        subject.valid?
#  #        expect(subject).to_not be_valid
#  #      end
#  #      it "on error will have a custom error message" do
#  #        subject.valid?
#  #        expect(subject.errors.messages[:department_area_id]).to include("Department Area ID must be an integer only")
#  #      end
#  #    end
#  #  end

#  #  context "should have constant variables" do
# 	# it "per_page constant should be set to 10" do
# 	#   expect(Issue::per_page).to be == 10
# 	# end

#  #    it "types constant array should have three values" do
#  #  	  expect(Issue::TYPES.length).to be == 3
#  #  	  expect(Issue::TYPES).to include("operational")
#  #  	  expect(Issue::TYPES).to include("mechanical")
#  #  	  expect(Issue::TYPES).to include("electrical")
# 	# end
#  #  end

#  #  it "will return the department area name" do
#  #  	department_area = FactoryGirl.create(:department_area)
#  #  	subject.department_area_id = department_area.id
#  #  	expect(subject.get_department_name).to eq "#{department_area.area.name} #{department_area.department.name}"
#  #  end

#  #  it "will return the impact name" do
#  #  	impact = FactoryGirl.create(:impact)
#  #  	subject.impact_id = impact.id
#  #  	expect(subject.get_impact_name).to eq impact.name
#  #  end

#  #  context "testing state" do
#  #  	subject { FactoryGirl.build(:issue) }
#  #  	its(:state) { should == "draft" }
#  #  	it "state should not be able to be set to 'publish'" do
#  #  		expect(subject.review_to_publish).to be false
#  #  		expect(subject.state).to_not be eq 'publish'
#  #  	end
#  #  	context "once state is set to review" do
#  #  		before { subject.draft_to_review }
#  #  		it "state should be equal to 'review'" do
# 	#   		expect(subject.state).to be == "review"
# 	#   	end
# 	#   	it "state should be able to be changed to 'draft'" do
# 	#   		expect(subject.review_to_draft).to be true
# 	#   		expect(subject.state).to be == "draft"
# 	#   	end
# 	#   	it "state should be able to change to 'draft' with the shortcut method" do
# 	# 		subject.change_state
# 	#   		expect(subject.state).to be == "draft"
# 	#   	end
#  #  		context "state should be able to be changed to 'publish'" do
#  #  			before { subject.review_to_publish }
#  #  			it "should be equal to 'publish'" do
# 	#   			expect(subject.state).to be == "publish"
# 	#   		end
# 	#   		it "should be able to set to review" do
# 	#   			expect(subject.publish_to_review).to be true
# 	#   			expect(subject.state).to be == "review"
# 	#   		end
# 	#   		it "should be able to be set to draft" do
# 	#   			expect(subject.publish_to_draft).to be true
# 	#   			expect(subject.state).to be == "draft"
# 	#   		end
# 	#   		it "should be able to change the state to 'draft' with the shortcut method" do
# 	#   			subject.change_state
# 	#   			expect(subject.state).to be == "draft"
# 	#   		end
#  #  		end
#  #  	end
#  #  end
end
