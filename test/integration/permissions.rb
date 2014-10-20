require 'test_helper'

class Permissions < ActionDispatch::IntegrationTest
	# include Devise::TestHelpers
	context "a read user" do
		setup do
			post '/api/login.json', session: {email: 'first@first.com', password: 'helloworld'}
		end

		should "be able to login" do
	 		assert_response 200
		end

		should "be able to logout" do
			delete "/api/logout"
			assert_response 204

			get '/api/issues.json'
			assert_response 401
		end

		should "be able to get a list of issues" do
			get '/api/issues.json'
			data = JSON.parse(response.body)
			assert_equal data['issues'].length, 1
			assert_equal data['issues'][0]['state'], 'publish'
			assert_response 200
		end

		should "be able not be able to edit an issue" do
			issue = issues(:first_issue)
			put "/api/issues/#{issue.id}.json", issue: {description: "changed words"}
			assert_response 401
		end

		should "not be able to create an issue" do
			issue = issues(:first_issue)
			post "/api/issues.json", issue: {name: "first", description: "first again"}
			assert_response 401
		end
	end

	context "a write user" do
		setup do
			post "/api/login.json", session: {email: 'second@first.com', password: 'helloworld'}
		end
		should "be able to login" do
			assert_response 200
		end

		should "be able to logout" do
			delete "/api/logout"
			assert_response 204

			get '/api/issues.json'
			assert_response 401
		end

		should 'redirect to 404 if cannot find an issue' do
			get "/api/issues/22.json"
			assert_redirected_to "/404.html"
		end

		should "be able to show an issue" do
			issue = issues(:first_issue)
			get "/api/issues/#{issue.id}.json"
			data = JSON.parse(response.body)
			assert_response 200
			assert data['issue'].present?
			assert_equal data['issue']['name'], issue.name
			assert_equal data['issue']['description'], issue.description
		end

		should "be able to retreive a list of issues" do
			get "/api/issues.json"

			data = JSON.parse(response.body)
			assert_equal data['issues'].length, 1
			assert_equal data['issues'][0]['state'], 'publish'
			assert_response 200
		end

		should "be able to create a new issue" do
			assert_difference 'Issue.count', 1 do
				post "/api/issues.json", issue: {name: 'first name', description: "first name"}
			end
			data = JSON.parse(response.body)
			assert data["issue"].present?
			assert_equal data['issue']['description'], "first name"
			# assert_equal data['issue']['state'], 'draft'
			assert_response 200
		end

		should "be able to edit an issue" do
			issue = issues(:first_issue)
			put "/api/issues/#{issue.id}.json", issue: {name: "changed name", description: "changed description"}
			data = JSON.parse(response.body)
			assert_equal data['issue']['description'], "changed description"
			assert_equal data['issue']['name'], "changed name"
			assert_response 200
		end

		should "not be able to destroy an issue" do
			issue = issues(:first_issue)
			assert_difference 'Issue.count', 0 do
				delete "/api/issues/#{issue.id}.json"
				assert_response 401
			end
		end
	end

	context "an admin user" do
		setup do
			post "/api/login.json", session: {email: "admin@issue.com", password: "helloworld"}
		end

		should "be able to login" do
			assert_response 200
		end

		should "be able to logout" do
			delete "/api/logout"
			assert_response 204

			get '/api/issues.json'
			assert_response 401
		end

		should "be able to retreive a list of issues" do
			get "/api/issues.json"
			data = JSON.parse(response.body)
			assert data['issues'].present?
			assert_equal data['issues'].length, 1
			assert_equal data['issues'][0]['state'], 'publish'
			assert_response 200
		end

		should "be able to create an issue" do
			assert_difference "Issue.count", 1 do
				post "/api/issues.json", issue: {name: "changed name", description: "changed again"}
			end
			data = JSON.parse(response.body)
			assert data['issue'].present?
			assert_equal data['issue']['name'], "changed name"
			assert_equal data['issue']['description'], "changed again"
			assert_response 200
		end

		should "be able to edit an issue" do
			issue = issues(:first_issue)
			put "/api/issues/#{issue.id}.json", issue: {name: "edit changed admin", description: "another description"}
			data = JSON.parse(response.body)
			assert data['issue'].present?
			assert_equal data['issue']['name'], "edit changed admin"
			assert_equal data['issue']['description'], "another description"
			assert_not_equal data['issue']['name'], issue.name
			assert_not_equal data['issue']['description'], issue.description
		end

		should "be able to destroy an issue" do
			issue = issues(:first_issue)
			assert_difference "Issue.count", -1 do
				delete "/api/issues/#{issue.id}.json"
			end
			assert_response 204
		end
	end
end