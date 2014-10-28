require 'spec_helper'

describe "static pages" do
	subject { page }
	describe "Home page" do
		before { visit '/users/sign_in' }
		it {should have_content("Sign in")}
	end
end