Rails.application.routes.draw do
  root "books#index"

  resources :books do
    collection do
      get :search
    end
    member do
      get :reader
    end
  end
  devise_for :users, only: [:sessions, :registrations]
end
