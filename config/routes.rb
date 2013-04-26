Topit::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  root to: 'static_pages#home'
  match '/post/:id/:name'=>'microposts#show',:name=>/[a-zA-z_0-9]+/i,:id=>/[0-9]+/
  match '/signin', to: 'sessions#new'
  match '/signinin', to: 'sessions#create'
  match '/signout', to: 'sessions#destroy'
  match '/signup', to: 'users#new'
  match '/signupup', to: 'users#create'
  match '/post',to: 'microposts#new'
  match '/commands/postit',to: 'microposts#create'
  match '/minipostit',to: 'miniposts#create'
  match '/commands/miniposts/inc', to: 'miniposts#increment'
  match '/commands/microposts/inc', to: 'microposts#increment'
  match '/commands/comments/inc', to: 'comments#increment'
  match '/commands/subscriptions', to: 'microposts#subscriptions'
  match '/commands/microposts/subscribe', to: 'microposts#subscribe'
  match '/commands/no_other_users', to: 'users#no_other_users'
  match '/commands/no_other_emails', to: 'users#no_other_emails'
  match '/commands/json/subscriptions', to: 'users#subscriptions'
  match '/commands/inc_a_comment', to: 'comments#increment'
  match '/commands/create_a_comment', to: 'comments#create'
  match '/search', to: 'microposts#search'
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
