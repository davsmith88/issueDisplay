require 'rails_helper'

RSpec.describe DetailedStep, type: :model do
	describe 'validations' do
		it { should validate_presence_of(:number).with_message('Step must have an index number') }
		it { should validate_numericality_of(:number).only_integer.with_message('Step Order must be a number') }
		it { should validate_presence_of(:description).with_message('Step must have a description') }
	end

	describe 'associations' do
		it { should belong_to :issue }
		it { should have_one(:medium) }
	end

end