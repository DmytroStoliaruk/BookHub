Rails.application.routes.draw do
  root "books#index"

  resources :books
  devise_for :users, only: [:sessions, :registrations]
  get '/search', to: 'search#index', as: :search
end
