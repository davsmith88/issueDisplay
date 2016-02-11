require 'spec_helper'

describe Impact do
	before { subject.valid? }
	subject { FactoryGirl.create(:impact) }

	context "validations" do
		context "with valid attributes" do
			subject { FactoryGirl.create(:impact)}
			it { should be_valid }
			it { should respond_to(:name) }
			it { should respond_to(:description) }
		end
		context "for no name present" do
			subject { FactoryGirl.build(:impact, name: nil) }

			it { should_not be_valid }
			it "will have an error message" do
				expect(subject.errors.messages[:name]).to include("Impact must have a name")
			end

		end
	end

	context "associations" do
		it { should belong_to(:business) }
		it { should have_many(:issues) }
	end

	context "constant variables" do
		it "should have 'per_page' pagination constant set to 5" do
			expect(Impact::per_page).to eq(5)
		end
	end

end