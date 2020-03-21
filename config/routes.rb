Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'index', to: 'pages#index', as: :index
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :nutritionist do
    resources :consultation_spots, only: [:index]
    resources :consultation, only: [:index]
    resources :calendars, only: [:index]
  end

  namespace :guest do
    resources :consultation_spots, only: [:index]
    resources :consultation, only: [:index]
    resources :calendars, only: [:index]
  end
end
