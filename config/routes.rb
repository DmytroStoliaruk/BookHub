Rails.application.routes.draw do
  root "books#index"

  resources :books do
    collection do
      get :search
    end
  end
  devise_for :users, only: [:sessions, :registrations]
end
