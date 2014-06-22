IssueDisplay::Application.routes.draw do
  devise_for :users
  
  root :to => 'static_pages#home'

  get "/home" => 'static_pages#home', as: :home
  

  get 'assignment/show/:role_id' => 'assignments#show', as: :assignment_role_view
  scope "/adminTesting" do
    resources :users
  end

  get '/profile' => 'users#profile', as: :profile

  resources :albums do
     resources :images
  end


  resources :businesses

  resources :assignments, only: [:new, :create, :destroy]

  
  resources :grants, only: [:new, :create]
  resources :admin 

  resources :issue_management


  resources :roles
  resources :rights

  resources :departments
  resources :areas
  resources :department_areas
  resources :impacts






  resources :issue_workarounds do
      resources :records, only: [:create, :index, :new]
      resources :images
  end

  resources :attempted_solutions do
    resources :records, only: [:create, :index, :new]
    resources :images
  end

  resources :solutions do
    resources :records, only: [:create, :index, :new]
    resources :images
  end

  # resources :issues do
  #   resources :records, only: [:create, :index, :new]
  #   resources :images
  # end

  get "/activities" => "notifications#activity_feed", as: :activity_feed
  get "/notifications" => "notifications#notification", as: :notification_feed




  resources :issues do
    member do
      get 'history', as: :history
      get 'draft_to_review', as: :draft_to_review
      get 'review_to_draft', as: :review_to_draft
      get 'review_to_publish', as: :review_to_publish
      get 'publish_to_review', as: :publish_to_review
      get 'publish_to_draft', as: :publish_to_draft
    end
    resources :notes do
      post 'mark_as_checked', as: :marked_as_checked
      post 'mark_as_user_read', as: :mark_as_user_read
    end
    resources :images
    resources :records, only: [:create, :index, :new]
    resources :issue_workarounds do
      # resources :records, only: [:create, :index, :new]
      # resources :images
    end
    resources :attempted_solutions do
      # resources :images
    end
    resources :solutions do
      # resources :images
    end
  end

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
