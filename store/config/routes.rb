Rails.application.routes.draw do
  # Home page
  root "home#index"

  # Sign up (new/create)
  resources :accounts, only: [:new, :create]

  # Email verification flow (no ID in URL, uses session)
  get  "accounts/verify", to: "accounts#verify", as: 'verify_accounts'
  post "accounts/verify", to: "accounts#process_verification"

  # Health check (keep this)
  get "up" => "rails/health#show", as: :rails_health_check

  # (Optional PWA, comment out unless needed)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
