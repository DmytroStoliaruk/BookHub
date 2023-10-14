# frozen_string_literal: true

Rails.application.routes.draw do
  resources :books

  # Defines the root path route ("/")
  root "books#index"
end
