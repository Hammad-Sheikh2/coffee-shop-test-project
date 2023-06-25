Rails.application.routes.draw do
  devise_for :users, defaults: {
    format: 'json'
  }, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  namespace :api do
    namespace :v1 do
      resources :items, only: %i[index show]
      resources :orders, only: %i[index create update]
    end
  end
end
