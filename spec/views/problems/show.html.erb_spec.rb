require 'rails_helper'

RSpec.describe "problems/show", type: :view do
  before(:each) do
    @problem = assign(:problem, Problem.create!(
      :name => "MyText",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
