require 'spec_helper'

describe Issue do
  before { subject.valid? }
  subject { Issue.new(name: "first issue") }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:review_date) }


  it { should belong_to(:user) }
  it { should belong_to(:impact) }
  it { should belong_to(:department_area) }

  it { should have_many(:solutions) }
  it { should have_many(:issue_workarounds) }
  it { should have_many(:attempted_solutions) }
  it { should have_many(:notes) }
  it { should have_many(:images) }
  it { should have_many(:records) }

  context "should have constant variables" do
	it "per_page constant should be set to 10" do
	  expect(Issue::per_page).to be == 10
	end

    it "types constant array should have three values" do
  	  expect(Issue::TYPES.length).to be == 3
  	  expect(Issue::TYPES).to include("operational")
  	  expect(Issue::TYPES).to include("mechanical")
  	  expect(Issue::TYPES).to include("electrical")
	end
  end

  context "testing state" do
  	subject { Issue.new(name: "first issue") }
  	its(:state) { should == "draft" }
  	it "state should not be able to be set to 'publish'" do
  		expect(subject.review_to_publish).to be false
  		expect(subject.state).to_not be == 'publish'
  	end
  	context "once state is set to review" do
  		before { subject.draft_to_review }
  		it "state should be equal to 'review'" do
	  		expect(subject.state).to be == "review"
	  	end
	  	it "state should be able to be changed to 'draft'" do
	  		expect(subject.review_to_draft).to be true
	  		expect(subject.state).to be == 'draft'
	  	end
  		context "state should be able to be changed to 'publish'" do
  			before { subject.review_to_publish }
  			it "should be equal to 'publish'" do
	  			expect(subject.state).to be == "publish"
	  		end
	  		it "should be able to set to review" do
	  			expect(subject.publish_to_review).to be true
	  			expect(subject.state).to be == 'review'
	  		end
	  		it "should be able to be set to draft" do
	  			expect(subject.publish_to_draft).to be true
	  			expect(subject.state).to be == 'draft'
	  		end
  		end
  	end
  end

  context "when name is not present" do
  	subject { Issue.new(name: "") }

  	let(:errors) { subject.errors[:name] }
  	it { should_not be_valid }
  	it { errors.should include("Issue needs to have a name")}
  end
end
