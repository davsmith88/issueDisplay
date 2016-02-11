require 'spec_helper'

describe "DetailedSteps" do
  describe "GET /detailed_steps" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get detailed_steps_path
      response.status.should be(200)
    end
  end
end
