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
      :passwords => "member_profile_passwords",
      :omniauth_callbacks => "omniauth_callbacks"
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
  get "sitemap" => "pages#sitemap", as: :sitemap
  get "pages/set_language", as: :set_language

  # get "sms_entry_point", :to => "sms#start_point"

  root 'pages#index'

end
