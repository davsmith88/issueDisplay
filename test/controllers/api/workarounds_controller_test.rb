require 'test_helper'

class Api::WorkaroundsControllerTest < ActionController::TestCase
	include Devise::TestHelpers

	test "should return workarounds for an issue" do
		issue = issues(:first_issue)
		user = users(:writeUser)
		sign_in user
		get :index, {format: :json, issue_id: issue.id}
		data = JSON.parse(response.body)
		# puts response.body
		assert data['workarounds'].present?, "Workarounds object must be present"
		assert_equal data['workarounds'].length, issue.issue_workarounds.length, "the workarounds returned should match the workaronds in the fixtures"
		assert_response 200
	end

	test "should create an issue workaround" do
		issue = issues(:first_issue)
		user = users(:writeUser)
		sign_in user
		assert_difference 'issue.issue_workarounds.length', 1 do
			post :create, {format: :json, workaround: {issue: issue.id, description: "another workaround"}}
			issue.reload
		end
		data = JSON.parse(response.body)
		assert data['workaround'].present?, "a workaround object must be present"
		assert data['workaround']['content'].present?, "a content field must be present in the responce"
		assert data['workaround']['id'].present?, "An id must be present in the json response"
		assert_equal data['workaround']['issue'], issue.id, "the returned id must be equal to the issue fixture id"
		assert_response 200
	end

	test "should update a workaround" do
		issue = issues(:first_issue)
		workaround = issue_workarounds(:one)
		user = users(:writeUser)
		sign_in user
		put :update, {format: :json, id: workaround.id, workaround: {description: "changed to this"}}
		data = JSON.parse(response.body)

		assert data['workaround'].present?, "a workaround object must be present"
		assert_equal data['workaround']['content'], "changed to this"
		assert_not_equal data['workaround']['content'], "place the system into manual and move the dam in"
		assert_equal data['workaround']['issue'], issue.id
		assert_response 200
	end

	test "should delete a workaround from an issue" do
		issue = issues(:first_issue)
		workaround = issue_workarounds(:one)
		user = users(:writeUser)
		sign_in user
		assert_difference 'issue.issue_workarounds.length', -1 do
			delete :destroy, {format: :json, id: workaround.id}
			issue.reload
		end
		assert_response 204
		assert_equal response.body.length, 0, "body should have nothing returned"
	end
end