require 'rails_helper'

RSpec.describe Review, type: :model do
	describe 'validations' do
		it { should validate_presence_of(:description).with_message('Workaround needs to have a description') }
		describe "should validate assigns review date" do
			let(:issue) { Issue.create(name: 'name', review_date: DateTime.now) }
			let(:review) { Solution.create(type: 'Solution', description: 'c') }
		end
	end
	describe 'associations' do
		it { should have_one(:medium) }
		it { should belong_to(:issue) }
		it { should belong_to(:user) }
	end 

	describe 'scopes' do
		describe 'checks the scopes of the review' do
			let(:issue) { Issue.create(name: "name", description: "des", review_date: DateTime.now) }
			let(:a) { IssueWorkaround.create(type: 'IssueWorkaround', description: 'a', issue_id: issue.id) }
			let(:b) { Solution.create(type: 'Solution', description: 'b', issue_id: issue.id) }
			
			before do
				
			end
			it "should return the workarounds for the issue" do
				expect(issue.issue_workarounds).to eq ([a])
			end
			it "should return the solutions for the issue" do
				expect(issue.solutions).to eq ([b])
			end

		end
	end
end