Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  post '/index' => 'welcome#show', as: 'search'
  post '/process-request' => 'twitterscanner#process_request'
  get  'users' => 'users#index'
  get  'users/profile' => 'users#show'
  post 'users/:id' => 'users#save_search', as: 'profile'
  get 'contact', to: 'messages#new', as: 'contact'
  post 'contact', to: 'messages#create'

  #routes for login, logout, sign in and sign up forms.
  # get 'login' => 'sessions#new'
  # post 'login' => 'sessions#create'
  # get 'logout' => 'sessions#destroy'
  #
  # get '/signup' => 'users#new'
  # post '/users' => 'users#create'

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
