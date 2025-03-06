Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "pages#home"

  # Authentication routes
  get "/auth/marvin/callback", to: "sessions#create"
  get "/auth/failure",         to: "sessions#failure"
  delete "/logout",            to: "sessions#destroy"

  resources :elections do
    resources :candidates
  end

  get "/vote",         to: "votes#new",     as: "new_vote"
  post "/vote",        to: "votes#create",  as: "votes"
  get "/vote/success", to: "votes#success", as: "votes_success"
end
