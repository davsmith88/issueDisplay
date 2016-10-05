require 'rails_helper'

RSpec.describe "problems/edit", type: :view do
  before(:each) do
    @problem = assign(:problem, Problem.create!(
      :name => "MyText",
      :description => "MyText"
    ))
  end

  it "renders the edit problem form" do
    render

    assert_select "form[action=?][method=?]", problem_path(@problem), "post" do

      assert_select "textarea#problem_name[name=?]", "problem[name]"

      assert_select "textarea#problem_description[name=?]", "problem[description]"
    end
  end
end
