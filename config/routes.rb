require "sidekiq/web"

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  admin_constraint = lambda do |request| 
    request.session[:init] = true
    request.env["rack.session"]["warden.user.user.key"] && User.find(request.env["rack.session"]["warden.user.user.key"][0][0]).is_admin?
  end  
  
  constraints admin_constraint do
    mount Sidekiq::Web => "/sidekiq"
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
  end

  devise_for :users, controllers:
    { omniauth_callbacks: "users/omniauth_callbacks",
      registrations: "users/registrations" }

  # Static pages
  get "/terms", to: "static_pages#terms", :as => :terms
  get "/privacy", to: "static_pages#privacy", :as => :privacy
  get "/google8fa477f418e49735.html", to: proc { |env| [200, {}, ["google-site-verification: google8fa477f418e49735.html"]] }
  get "/sitemap.xml", to: "sitemap#index", format: "xml", as: :sitemap

  # You can have the root of your site routed with "root"
  root to: redirect("/coins")
  resources :bittrex_integrations
  resources :coins
  namespace :portfolio do
    root to: "portfolio#index"

    resources :transactions do
      get :autocomplete_coin_name, :on => :collection
    end
  end

  authenticated :user do
    resources :bittrex_orders_history_imports, only: %i(new create)
  end

  resources :exchanges

  # API section
  namespace :api do
    namespace :v1 do
      resource :login, only: :create, controller: :login
    end
  end

  get "*path" => redirect("/")
end
