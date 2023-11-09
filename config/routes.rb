Rails.application.routes.draw do
  root "books#index"

  resources :books
  get '/search', to: 'books#search', as: 'search_books'
  devise_for :users, only: [:sessions, :registrations]
end
