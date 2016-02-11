require 'spec_helper'

describe ApplicationController do
  controller do
    def index
      raise ApplicationController::AccessDenied
    end

    def new
      raise CanCan::AccessDenied
    end

    def show
      raise ActiveRecord::RecordNotFound
    end
  end

  describe "handling AccessDenied expections" do
    it "redirects to the /401.html page" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "handling cancan access denied expections" do
  
    it "redirects to the 'issues_path'" do
      sign_in FactoryGirl.create(:user, permType: 'viewer')
      get :new
      expect(response).to redirect_to(issues_path)
    end

    it "has an error message" do
      sign_in FactoryGirl.create(:user, permType: 'viewer')
      get :new
      expect(flash[:alert]).to_not be_nil
    end
  end

  describe "handing record not found" do
    before do
      routes.draw { get "show" => "anonymous#show" }
       sign_in FactoryGirl.create(:user, permType: 'viewer')
    end
    it "redirects to issues path" do
      get :show
      expect(response).to redirect_to issues_path
    end

    it "displays the flash message" do
      get :show
      expect(flash[:alert]).to eq "The issue the ID '' does not exist"
    end
  end

end