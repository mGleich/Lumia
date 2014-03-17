Lumia::Application.routes.draw do

  resources :contact_partners


  resources :telenumbers_of_clients


  resources :emails_of_clients


  root to: 'pages#index'

  get "login" => "sessions#new", as: "login"
  post "sessions" => "sessions#create", as: "sessions"
  delete "logout" => "sessions#destroy", as: "logout"

  resources :users

  resources :pages, only: [:admin_menu, :index]

  get "pages/admin_menu" => "pages#admin_menu"

  get "new_event_to_client/:id" => "events#new", as: :add_event_to_client


  get "clients/:id/show_events_to_client" =>"clients#events_to_client", as: :events_to_client


  post "results/new" => "results#create"

  #Die Einträge brauche ich daran ist die Vererbung schuld
  get "results/new" => "results#new", as: :result_state_changes

  get "results/new" => "results#new", as: :result_locks

  get "results/new" => "results#new", as: :result_change_event_type_amounts

  get "results/new" => "results#new", as: :result_infos

  get "results_of_state_change/:id/" => "results#show", as: :result_state_change

  get "results_of_change_event_type_amount/:id/" => "results#show", as: :result_change_event_type_amount

  get "results_of_info/:id" => "results#show", as: :result_info

  get "results_of_look/:id" => "results#show", as: :result_lock

  put "results_of_state_change/:id/" => "results#update"

  put "results_of_change_event_type_amount/:id/" => "results#update"

  put "results_of_info/:id" => "results#update"

  put "results_of_look/:id" => "results#update"

  delete "results_of_state_change/:id/" => "results#destroy", as: :result_state_change

  delete "results_of_change_event_type_amount/:id/" => "results#destroy", as: :result_change_event_type_amount

  delete "results_of_info/:id" => "results#destroy", as: :result_info

  delete "results_of_look/:id" => "results#destroy", as: :result_lock


  get "rule_straight/:id" => "rules#show", as: :rule_straight

  get "rule_with_parts/:id" => "rules#show", as: :rule_with_part

  put "rule_straight/:id" => "rules#update", as: :rule_straight

  put "rule_with_parts/:id" => "rules#update", as: :rule_with_part

  delete "rule_straight/:id" => "rules#destroy"

  delete "rule_with_parts/:id" => "rules#destroy"



  resources :regular_expressions


  resources :clients


  resources :adresses


  resources :releases


  resources :results


  resources :rules


  resources :part_of_rules


  resources :events


  resources :event_types


  resources :states



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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
