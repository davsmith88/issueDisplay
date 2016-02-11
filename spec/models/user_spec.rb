require 'spec_helper'
require "cancan/matchers"

describe User do
  # before { subject.valid? }
  describe "abilities" do
    subject(:ability) { Ability.new(user) }
    let(:user) { nil }

    context "when user is an administrator" do
      let(:user) { FactoryGirl.create(:user, permType: 'admin') }
      [:index, :new, :create, :edit, :update, :destroy].each do |action|
        it { should be_able_to action, Impact }
        it { should be_able_to action, Department }
        it { should be_able_to action, Area }
      end
    end

    context "when user is a creator" do
      let(:user) { FactoryGirl.create(:user, permType: 'creator') }
      [:index, :new, :create, :edit, :update, :destroy].each do |action|
        it { should_not be_able_to action, Impact}
        it { should_not be_able_to action, Department }
        it { should_not be_able_to action, Area }
      end
   
    end
    context "when the user is a viewer" do
      let(:user) { FactoryGirl.create(:user, permType: 'user') }
      [:index, :new, :create, :edit, :update, :destroy].each do |action|
        it { should_not be_able_to action, Impact}
        it { should_not be_able_to action, Department }
        it { should_not be_able_to action, Area }
      end
    end

  end
end