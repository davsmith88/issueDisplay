require 'spec_helper'

describe DepartmentsController do
  before :all do
    @user = FactoryGirl.create(:user, permType: 'admin')
  end

  context "GET #index", type: 'index' do
    let!(:users) { 3.times.map { FactoryGirl.create(:department) } }
    before do
      sign_in @user
      get :index
    end
    it {should render_with_layout "departments_area"}
    it "returns array of departments" do
      expect(assigns(:departments)).to match_array users
    end
    it "should have an instance variable names 'active_workarounds'" do
      expect(assigns(:active_departments)).to eq true
    end
  end

  context "GET #new", type: 'new' do
    before do
      sign_in @user
      get :new
    end
    it { should render_template :new }
    it { should render_with_layout "departments_area" }
    it { expect(assigns(:active_departments)).to eq true }
  end

  context "GET #edit", type: 'edit' do
    let(:department) { FactoryGirl.create(:department) }
    before do
      sign_in @user
      get :edit, id: department
    end

    it { should render_template :edit }
    it { should render_with_layout :admin_layout }
  end

  context "POST #create", type: 'create' do
    context "with valid attributes" do
      let(:department_attrs) { FactoryGirl.attributes_for(:department) }
      before do
        sign_in @user
        post :create, department: department_attrs
      end
      it { expect(assigns(:department)).to be_kind_of(Department) }
      it { should redirect_to departments_path }
      it "will be saved to database" do
        expect { post :create, department: department_attrs }.to change(Department, :count).by 1
      end
    end
    context "with invalid attributes" do
      let(:department_attrs) { FactoryGirl.attributes_for(:department, name: nil) }
      before do
        sign_in @user
        post :create, department: department_attrs
      end
      it "will not save the department with invalid attrs" do
        expect { post :create, department: department_attrs }.to change(Department, :count).by 0
      end
      it { should render_template :new }
      it { should render_with_layout :admin_layout }
    end
  end

  context "PATCH #update", type: 'update' do
    before do
      sign_in @user
    end
    context "with valid attrs" do
      let(:department_attrs) { FactoryGirl.attributes_for(:department, name: "changed name") }
      before do
        @department = FactoryGirl.create(:department, name: "start")
        patch :update, id: @department, department: department_attrs
      end
      it "should persist the data to the database" do
        patch :update, id: @department, department: department_attrs
        expect(assigns(:department).name).to eq "changed name"
        expect(assigns(:department).name).to_not eq "start"
      end
      it { should redirect_to departments_path }
    end
    context "with invalid attrs" do
      let(:department_attrs) { FactoryGirl.attributes_for(:department, name: nil) }
      before do
        @department = FactoryGirl.create(:department, name: "start")
        patch :update, id: @department, department: department_attrs
      end
      it "should not change the department data" do
        @department.reload
        expect(@department.name).to eq "start"
      end
      it { should render_template :edit }
      it { should render_with_layout :admin_layout }
    end
  end

  context "DESTROY #destroy", type: 'destroy' do
    let!(:department) { FactoryGirl.create(:department) }
    before do
      sign_in @user
    end
    it "destroys the department" do
      expect { delete :destroy, id: department.id }.to change(Department, :count).by(-1)
    end
    it "redirects to departments_path" do
      delete :destroy, id: department
      expect(response).to redirect_to departments_path
    end
    it "renders a flash message" do
      delete :destroy, id: department
      expect(flash[:notice]).to eq "Department was destroyed"
    end
  end
end