Rails.application.routes.draw do
  resources :processareas

  resources :lineups

  get "/c/:location/:machine_code" => "complaints#show", as: :indiv_show_complaint
  get "/complaints/all" => "complaints#all"
 get "/pages/:page" => "pages#show"
  

  resources :images
  resources :complaints
  get 'a/image_management' => 'images#manindex', as: :image_management

  get "/api/get_images" => 'images#get_images', as: :get_images_json


  # resources :detailed_steps

  # match "*all" => "application#cors_preflight_check", :constraints => {:method => "OPTIONS"}

  # resources :qwers
  devise_for :users
  # devise_for :users, :controllers => {:sessions => "json_sessions"}


  post "/api/login" => 'json_sessions#create'
  delete "/api/logout" => 'json_sessions#destroy'


  match "issues", to: "issues#index", via: [:options]
  match "issues/:issue_id/issue_workarounds/:id", to: "issue_workarounds#cors", via: [:options]

  # resources :json_sessions

  # root :to => 'static_pages#home'
  root :to => 'issues#index'

  get "/about" => 'static_pages#about', as: :static_about
  get "/why" => 'static_pages#why', as: :static_why
  get "/products" => 'static_pages#products', as: :static_products

  get "/home" => 'static_pages#home', as: :home
  get '/layout' => 'layouts_show#show', as: :layouts_show

  get 'assignment/show/:role_id' => 'assignments#show', as: :assignment_role_view

  namespace :jobs do
    resources :jobs
    resources :steps
  end

  scope "/admin" do
    get "/", to: "admin#index", as: "admin_index"
    get "users", to: "admin#users", as: "admin_user_static"
    # get "permissions", to: "admin#permissions", as: "admin_permission_static"

    get "business", to: 'admin_business#edit', as: "business_edit"
    put "businesses/:id(.:format)", to: "admin_business#update", as: "business_update"

    get "depareas/departments", to: "admin#departments", as: "admin_departments_static"
    get "depareas/areas", to: "admin#areas", as: "admin_areas_static"
    get "depareas/department_areas", to: "admin#department_areas", as: "admin_department_areas_static"
    resources :users, only: [:new, :create, :update, :destroy, :edit, :show]
    # resources :assignments, only: [:new, :create, :destroy]


    # resources :grants, only: [:new, :create, :destroy]
    resources :admin

    resources :issue_management do
    # resources :issue_management, param: :issue_id do
      get 'view', as: :view
      member do
        get 'show_workarounds', as: :show_workarounds
        get 'show_solutions', as: :show_solutions
        get 'show_steps', as: :show_steps

        # get 'show_attempted_solutions', as: :show_att_sol
        # get 'edit/images' => "issue_management#edit_images", as: :edit_images
        # get 'edit/workarounds' => "issue_management#edit_workaround", as: :edit_workaround
        # get 'edit/solutions' => "issue_management#edit_solutions", as: :edit_solutions


        # get 'edit/attempted_solutions' => "issue_management#edit_attempted_solutions", as: :edit_attempted_solutions
        


      end
      resources :issue_workarounds, controller: 'review_management', type: 'IssueWorkaround', u: 'workaround'
      resources :solutions, controller: 'review_management', type: 'Solution', u: 'solutions'
      # resources :attempted_solutions, controller: 'review_management', type: 'AttemptedSolution', u: 'attempted_solutions'
    end

    resources :department_areas do
      resources :locations
    end


    # resources :roles
    # resources :rights

    resources :departments
    resources :areas
    resources :department_areas
    resources :impacts
  end

  get '/profile' => 'users#profile', as: :profile

  # resources :albums do
  #    resources :images
  # end

  # namespace :api do
  #   match "issues", to: "issues#index", via: [:options]
  #   match "workarounds", to: "workarounds#cors", via: [:options]
  #   match "workarounds/:workaround_id", to: "workarounds#cors", via: [:options]
  #   # cors support, client will send a request to see if the correct headers are returned
  #   # just matches to cors method in the controller so no data will be sent back to the client
  #   match "solutions", to: "solutions#cors", via: [:options]
  #   match "solutions/:solution_id", to: "solutions#cors", via: [:options]
  #   resources :issues
  #   resources :workarounds
  #   resources :solutions
  # end

  # scope "/t" do
  #   resources :issues do
  #     resources :solutions, controller: 'reviews', type: 'Solution'
  #     resources :workarounds, controller: 'reviews', type: 'IssueWorkaround'
  #     resources :attempted, controller: 'reviews', type: 'AttemptedSolution'
  #   end
  # end


  resources :businesses do
    member do
      get 'newly_created', as: :newly_created
    end
  end

  # resources :assignments, only: [:new, :create, :destroy]


  # resources :grants, only: [:new, :create]
  # resources :admin

  # resources :issue_management


  # resources :roles
  # resources :rights

  # resources :departments
  # resources :areas
  # resources :department_areas
 






  



  # resources :issues do
  #   resources :records, only: [:create, :index, :new]
  #   resources :images
  # end

  get "/activities" => "notifications#activity_feed", as: :activity_feed
  get "/notifications" => "notifications#notification", as: :notification_feed


  get '/issues/search' => "issues#search", as: :issue_search
  get 'search_results' => "issues#search_results", as: :search_results

  resources :issues do
    member do
      get 'show_workarounds' => "reviews#index", type: 'IssueWorkaround', u: 'workarounds', as: :show_workarounds
      get 'show_solutions' => "reviews#index", type: 'Solution', u: 'solutions', as: :show_solutions
      # get 'show_attempted_solutions', as: :show_att_sol
      get 'show_steps' => "detailed_steps#index", as: :show_steps
      get 'show_images', as: :show_images
      get 'history', as: :history
      get 'draft_to_review', as: :draft_to_review
      get 'review_to_draft', as: :review_to_draft
      get 'review_to_publish', as: :review_to_publish
      get 'publish_to_review', as: :publish_to_review
      get 'publish_to_draft', as: :publish_to_draft
      # get 'edit/basic' => "issues#edit_basic", as: :edit_basic
      get 'edit/images' => "issues#edit_images", as: :edit_images
      get 'edit/workarounds' => "issues#edit_workaround", as: :edit_workaround
      get 'edit/solutions' => "issues#edit_solutions", as: :edit_solutions
      get 'edit/attempted_solutions' => "issues#edit_attempted_solutions", as: :edit_attempted_solutions
    end
    resources :detailed_steps do
      collection do
        post 'step_number_update'
        get 'quick_show'
      end
    end
    # get 'show_steps' => "detailed_steps#show", as: :show_issues_steps
    resources :notes do
      post 'mark_as_checked', as: :marked_as_checked
      post 'mark_as_user_read', as: :mark_as_user_read
    end
    # resources :images, controller: 'img', type: "Issue"
    resources :records, only: [:create, :index, :new]
    # resources :issue_workarounds do
    #   # resources :records, only: [:create, :index, :new]
    #   # resources :images
    # end
    # resources :attempted_solutions do
    #   # resources :images
    # end
    # resources :solutions do
    #   # resources :images
    # end
    resources :solutions, controller: 'reviews', type: 'Solution', u: 'solutions' do
      # resources :images, type: "Solution"
    end
    resources :issue_workarounds, controller: 'reviews', type: 'IssueWorkaround', u: 'workarounds' do
      # resources :images, type: 'IssueWorkaround'
    end
    # resources :attempted_solutions, controller: 'reviews', type: 'AttemptedSolution', u: 'attempted_solutions' do
    #   resources :images, type: "AttemptedSolution"
    # end
  end

  # resources :detailed_steps do
  #      resources :media
  # end
  resources :media, only: [:show, :new, :create, :destroy]
  # resources :issue_workarounds do
  #   resources :records, only: [:create, :index, :new]
  #   resources :images
  # end

  # resources :attempted_solutions do
  #   resources :records, only: [:create, :index, :new]
  #   resources :images
  # end

  # resources :solutions do
  #   resources :records, only: [:create, :index, :new]
  #   resources :images
  # end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
