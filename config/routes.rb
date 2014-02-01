require 'sidekiq/web'

Ahantu::Application.routes.draw do

  resources :contact_forms

  resources :shop_requests
  resources :locations
  resources :search_suggestions
  # resources :contacts
  resources :confirmations
  resources :descriptions
  resources :line_items
  resources :bookings

  resources :searches do
    member do
      get 'finalize'
    end
  end

  resources :shops do
    resources :items do
      member do
        get 'photos'
      end
    end
    member do
      get 'photos'
    end
  end

  resources :credit_cards

  mount Sidekiq::Web, at: "/sidekiq"

  resources :carts do
    collection do
      get 'one_click_checkout'
    end
  end
  get 'carts/:id/checkout' => 'carts#edit', as: :checkout

  ####################################
  # Profile routes
  ####################################
  devise_for :member_profiles,
    :controllers => {
      :registrations => "member_profile_registrations",
      :sessions => "member_profile_sessions",
      :passwords => "member_profile_passwords"
    }

  # devise_for :salesperson_profiles,
  #   :controllers => {
  #     # :registrations => "devise_profile_registrations",
  #     # :sessions => "devise_profile_sessions",
  #     # :passwords => "devise_passwords"
  #   }

  ####################################
  #
  ####################################
  get "about" => "pages#about", as: :about
  get "terms" => "pages#terms", as: :terms
  get "contact" => "pages#contact", as: :contact
  get "pages/set_language", as: :set_language

  # get "sms_entry_point", :to => "sms#start_point"

  root 'pages#index'

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
