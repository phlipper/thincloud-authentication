Rails.application.routes.draw do

  mount Thincloud::Authentication::Engine => "/auth"

  namespace :thincloud do
    namespace :authentication do
      match "auth/:provider/callback" => "registrations#create"
      get "auth/failure", to: "sessions#new"

      get "login", to: "sessions#new", as: "login"
      delete "logout", to: "sessions#destroy", as: "logout"
      get "authenticated", to: "sessions#authenticated"

      resources :registrations, only: [:new, :create]
      get "signup", to: "registrations#new", as: "signup"
      get "verify/:token", to: "registrations#verify", as: "verify_token"
    end
  end

  match "auth/:provider/callback" => "thincloud/authentication/registrations#create", as: "auth_callback"
  get "auth/failure", to: "thincloud/authentication/sessions#new"
  get "login", to: "thincloud/authentication/sessions#new"

  root to: "thincloud/authentication/sessions#new"
end