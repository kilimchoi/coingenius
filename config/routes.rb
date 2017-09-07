Rails.application.routes.draw do
  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers:
    { omniauth_callbacks: "users/omniauth_callbacks",
      registrations: "users/registrations" }

  # Static pages
  get "/terms", to: "static_pages#terms", :as => :terms
  get "/privacy", to: "static_pages#privacy", :as => :privacy
  get "/landing_page", to: "static_pages#landing_page", as: :landing_page
  get '/google8fa477f418e49735.html', to: proc { |env| [200, {}, ["google-site-verification: google8fa477f418e49735.html"]] }

  # You can have the root of your site routed with "root"
  root to: redirect("/coins")
  resources :bittrex_integrations
  resources :coins
  namespace :portfolio do
    get "/" => "portfolio#index"
    resources :transactions do
      get :autocomplete_coin_name, :on => :collection
    end
  end

  resources :exchanges
  # Example of regular route:
  #   get "products/:id" => "catalog#view"

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get "products/:id/purchase" => "catalog#purchase", as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get "short"
  #       post "toggle"
  #     end
  #
  #     collection do
  #       get "sold"
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
  #       get "recent", on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post "toggle"
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
