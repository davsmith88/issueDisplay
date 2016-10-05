require 'rails_helper'

RSpec.describe "problems/new", type: :view do
  before(:each) do
    assign(:problem, Problem.new(
      :name => "MyText",
      :description => "MyText"
    ))
  end

  it "renders new problem form" do
    render

    assert_select "form[action=?][method=?]", problems_path, "post" do

      assert_select "textarea#problem_name[name=?]", "problem[name]"

      assert_select "textarea#problem_description[name=?]", "problem[description]"
    end
  end
end
