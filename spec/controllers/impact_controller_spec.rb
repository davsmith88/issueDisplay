require 'spec_helper'

describe ImpactsController do
	render_views
	before :all do
  	@user_admin = FactoryGirl.create(:user, permType: 'admin' )
	end

	describe "GET #index", type: 'index' do
		before do
			@i1 = FactoryGirl.create(:impact)
			@i2 = FactoryGirl.create(:impact)
			@i3 = FactoryGirl.create(:impact)

      sign_in @user_admin
      get :index
		end
    it "returns list of impacts" do
      expect(assigns(:impacts)).to match_array([@i1, @i2, @i3])
    end
    it { should render_with_layout "admin_layout" }
	end

	describe 'GET #new', type: 'new' do
			context 'user is authorized and authenticated' do
				before do
					sign_in @user_admin
          get :new
				end
				it "should render the new template" do
					expect(response).to render_template('new')
				end
				it "should render the admin layout" do
					expect(response).to render_template('layouts/admin_layout')
				end
				it 'should render the "form" partial' do
					expect(response).to render_template(partial: '_form')
				end
				it 'should have an instance varible defined' do
					expect(assigns[:impact]).to be_an(Impact)
				end
			end
	end

	describe 'POST #create', type: 'create' do
			context 'user is authorized and authenticated' do
				before do
					sign_in @user_admin
					@i = Impact.create!(FactoryGirl.attributes_for(:impact))
				end
				context "with valid attrs" do
					before do
						@impact = FactoryGirl.attributes_for(:impact, name: "this is a name")
					end
					subject { post :create, impact: @impact }
					it "saves the impact to the database" do
						expect { subject }.to change(Impact, :count).by(1)
					end
					it { should redirect_to impacts_path }
					it "has a flash message" do
						post :create, impact: @impact
						expect(flash[:notice]).to eq("An impact has been created")
					end
				end	
				context "with invalid attrs" do
					before do
						@impact_invalid = FactoryGirl.attributes_for(:impact, name: nil)
					end
					subject { post :create, impact: @impact_invalid }
					it "does not save to database" do
						expect { subject }.to change(Impact, :count).by 0
					end
					it { should render_template(partial: '_form') }
					it { should render_with_layout 'admin_layout' }
				end
			end
	end

	describe 'GET #edit', type: 'edit' do
		before do
			@impact = FactoryGirl.create(:impact)
		end
		context "user is authorized and authenicated" do
			before do
				sign_in @user_admin
				get :edit, id: @impact.id
			end
			it { should render_template "edit" }
			it { should render_with_layout "admin_layout" }
			it { should render_template partial: '_form' }
			it { expect(assigns[:impact]).to eq @impact }
		end
	end

  describe 'PATCH #update', type: 'update' do
  	before do
  		@impact = FactoryGirl.create(:impact, name: "starting name")
  	end
      context "user is authorized and authenicated" do
      	before do
      		sign_in @user_admin
      	end
      	context "inserts the correct params" do
      		let!(:impact) { FactoryGirl.create(:impact, name: "starting name") }
      		before do
      			patch :update, id: impact.id, impact: FactoryGirl.attributes_for(:impact, name: "changed")
      			impact.reload
      		end
      		it { expect(assigns(:impact)).to be_kind_of(Impact) }
      		it { expect(assigns(:impact).id).to eq impact.id }
      		it { expect(impact.name).to eq "changed" }
      		it { expect(impact.name).to_not eq "starting name" }
      		it { should redirect_to impacts_path }
      		it "sets the flash message" do
      			expect(flash[:notice]).to eq "The impact has been successfully saved"
      		end
      	end
      	context "inserts the incorrect params" do
      		let!(:impact) { FactoryGirl.create(:impact, name: "starting name") }
      		before do
      			patch :update, id: impact.id, impact: FactoryGirl.attributes_for(:impact, name: nil)
      			impact.reload
      		end
      		it "will not change attrs" do
      			expect(impact.name).to eq "starting name"
      		end
      		it { should render_template 'edit' }
      		it { should render_with_layout 'admin_layout' }
      	end
      end
  end

  describe 'DESTROY #destroy', type: 'destroy' do
  	context "user is authorized and authenticated" do
  		before do
  			sign_in @user_admin
  			@impact = FactoryGirl.create(:impact)
  		end
  		it "destroy the issue" do
  			expect{ delete :destroy, id: @impact }.to change(Impact, :count).by -1
  		end
  		it "diplay the flash message" do
  			delete :destroy, id: @impact
  			expect(flash[:notice]).to eq "Impact has been destroyed"
  		end
  		it "redirects to impacts path" do
  			delete :destroy, id: @impact
  			expect(response).to redirect_to impacts_path
  		end
  	end
  end
end