Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
        post '/login', to: 'auth#create'
        get '/validate', to: 'auth#validate'
        resources :lookups, only: [:index]
        resources :owners, only: [:show, :create, :update]
        resources :pets, only: [:show, :create, :update]
    end
  end

  root 'static#index'
  get '/', to: 'static#index'
  get '*other', to: 'static#index'
end
