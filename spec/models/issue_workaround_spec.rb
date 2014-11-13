require 'spec_helper'

describe IssueWorkaround do
	before { subject.valid? }
	subject { FactoryGirl.create(:issue_workaround) }

	it "should have a valid factory" do
		FactoryGirl.create(:issue_workaround).should be_valid
	end
	# tests for attributes
	it {should respond_to :description}
	# tests for associations
	it {should have_many :records}
	it {should have_many :images}
	it {should belong_to :issue}
	# tests for validations
	context "validations" do
		context "for description" do
			before { subject.valid? }
			subject { FactoryGirl.build(:invalid_workaround) }
			it { should_not be_valid }

			it "it will have an error message" do
				expect(subject.errors.messages[:description]).to include("Workaround needs to have a description")
			end
		end
	end
end