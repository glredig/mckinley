Rails.application.routes.draw do
  namespace :auth do
    resource :facebook, only: :create
  end
end
