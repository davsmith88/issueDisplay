require 'test_helper'

class Api::SolutionsControllerTest < ActionController::TestCase
	include Devise::TestHelpers
	test "show (GET) the solutions for an issue" do
		issue = issues(:first_issue)
		user = users(:writeUser)
		sign_in user
		get :index, {format: :json, issue_id: issue.id}
		data = JSON.parse(response.body)
		assert data['solutions'].present?, "a solutions object must be present"
		assert_equal data['solutions'].length, issue.solutions.length
		assert_response 200
	end

	test "should (POST) create a new solution" do
		issue = issues(:first_issue)
		user =  users(:writeUser)
		sign_in user
		assert_difference "issue.solutions.length", 1 do 
			post :create, {format: :json, solution: {issue: issue.id, content: "some random words"}}
			issue.reload
		end
		data = JSON.parse(response.body)
		assert data['solution'].present?, "a solutions object must be present"
		assert_equal data['solution']['content'], "some random words"
		assert_equal data['solution']['issue'], issue.id, "returns the correct issue id"
		assert_response 200
	end

	test "shoud (PUT) update a solution" do
		solution = solutions(:one)
		user = users(:writeUser)
		sign_in user
		put :update, {format: :json, id: solution.id, solution: {content: "changed words"}}
		data = JSON.parse(response.body)
		assert data['solution'].present?, "a solutions object must be present"
		assert_equal data['solution']['content'], "changed words"
		assert_not_equal data['solution']['content'], solution.content
		assert_response 200
	end

	test "should (DELETE) destroy a solution" do
		issue = issues(:first_issue)
		solution = solutions(:one)
		user = users(:writeUser)
		sign_in user
		assert_difference 'issue.solutions.length', -1 do
			delete :destroy, {format: :json, id: solution.id}
			issue.reload
		end
		assert_response 204
		assert_equal response.body.length, 0, "An empty body must be returned"
	end
end