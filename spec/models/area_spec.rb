require 'spec_helper'

describe Area do
  subject { FactoryGirl.create(:area) }
  before { subject.valid? }
  context "associations" do
    it { should have_many(:department_areas) }
  end

  context "validations" do
    it { should validate_presence_of(:name).with_message("Each area must be provided with a name") }
    it { should validate_presence_of(:description).with_message("Each area must have a formal description") }
  end

  context "attributes" do
    it { should respond_to :name }
    it { should respond_to :description }
  end

  context "constant variables" do
    it "should set the per_page variable to 8" do
      expect(Area::per_page).to be 8
    end
  end
end