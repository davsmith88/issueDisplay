require 'spec_helper'

describe AreasController do
  before :all do
    @user = FactoryGirl.create(:user, permType: "admin")
  end
  context "GET #index", type: 'index' do
    let!(:areasq) { 4.times.map { FactoryGirl.create(:area) } }
    before do
      sign_in @user
      get :index
    end
    it { should render_with_layout "departments_area" }
    it "should have an instance variable named 'areas'" do
      expect(assigns(:areas)).to exist
    end
    it "should have an instance variable names 'active_areas' to eq true" do
      expect(assigns(:active_areas)).to eq true
    end
    it "should return the areas" do
      expect(assigns(:areas)).to match_array(areasq)
    end
  end
  context "GET #new", type: 'new' do
  end
  context "GET #edit", type: 'edit' do
  end
  context "POST #create", type: 'create' do
  end
  context "PATCH #update", type: 'update' do
  end
  context "DELETE #destroy", type: 'destroy' do
  end
end