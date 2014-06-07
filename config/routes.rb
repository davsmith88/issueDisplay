IssueDisplay::Application.routes.draw do
  devise_for :users
  
  root :to => 'static_pages#home'

  get "/home" => 'static_pages#home', as: :home
  

  get 'assignment/show/:role_id' => 'assignments#show', as: :assignment_role_view
  scope "/adminTesting" do
    resources :users
  end

  resources :records, only: [:create, :index]

  resources :albums do
     resources :images
  end


  resources :businesses

  resources :assignments, only: [:new, :create, :destroy]

  
  resources :grants, only: [:new, :create]
  resources :admin
  resources :roles
  resources :rights

  resources :departments
  resources :areas
  resources :department_areas
  resources :impacts

  resources :issues do
    resources :issue_workarounds do
      resources :records, only: [:create, :index]
      resources :images
    end
    resources :attempted_solutions do
      resources :images
    end
    resources :solutions do
      resources :images
    end
    resources :images
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
