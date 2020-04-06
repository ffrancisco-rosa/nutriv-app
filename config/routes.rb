Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: 'pages#home'
  get 'index', to: 'pages#index', as: :index
  #
  # route due to google auth


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :nutritionist do
    resources :consultation_spots, only: [:index]
    resources :consultations, only: [:index, :show, :new, :create]
    resources :calendars, only: [:index]
    resources :tasks, only: [:index, :new, :create, :edit]
  end

  # namespace :guest do
  #   resources :consultation_spots, only: [:index]
  #   resources :consultation, only: [:index]
  #   resources :calendars, only: [:index]
  # end
end
