require 'rails_helper'

RSpec.describe "problems/index", type: :view do
  before(:each) do
    assign(:problems, [
      Problem.create!(
        :name => "MyText",
        :description => "MyText"
      ),
      Problem.create!(
        :name => "MyText",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of problems" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
