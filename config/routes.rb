Rails.application.routes.draw do
  resources :tests, only: [:index]
end
