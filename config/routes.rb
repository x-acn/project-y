Alpha::Application.routes.draw do
  
  match '/login' => 'sessions#new', :as => 'login'
  match '/logout' => 'sessions#destroy', :as => 'logout'
  post '/sessions' => 'sessions#create'
  
  resources :templates, :only => [:index]
  
  ## Routes that are only applicable to the main site ##
  constraints :domain => Config::DOMAIN, :subdomain => Config::RESERVED_SUBDOMAINS_REGEX do
    resources :users
    resources :sites, :only => [:new, :create]
    root :to => 'main#index'
    #Catch-all route for main domain/site, to prevent catching below
    match '*invalidpath' => redirect("")
  end
  
  ## Dynamic catch-all routes for user pages ##
  get 'new/*slug' => 'pages#new', :as => 'new_page'
  get 'edit/(*slug)' => 'pages#edit', :as => 'edit_page'
  post 'update/(*slug)' => 'pages#update', :as => 'update_page'
  get '(*slug)' => 'pages#show', :as => 'show_page'
  put '*slug' => 'pages#create'
    
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
