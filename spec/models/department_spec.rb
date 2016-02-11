require 'spec_helper'

describe Department do
  subject { FactoryGirl.build(:department) }

  context "validations" do
    context "name" do
      it do
        should validate_presence_of(:name).with_message "Department needs to have a name"
      end
      it do
        should validate_presence_of(:description).with_message "Description needs to be filled out"
      end
    end
  end
  context "associations" do
    it { should have_many(:department_areas) }
    it { should have_many(:areas).through(:department_areas) }
    it { should have_many(:issues).through(:department_areas) }
  end
  context "constant variables" do
    it "should have a per page variables set to 8" do
      expect(Department::per_page).to eq 8
    end
  end
end