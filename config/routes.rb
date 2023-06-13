Rails.application.routes.draw do
  get '/api/v1/payments/create_checkout_url'
  get '/current_user', to: 'current_user#index'

  devise_for :users, path: '', path_names: {
    sign_in: 'api/v1/login',
    sign_out: 'api/v1/logout',
    registration: 'api/v1/register'
  }, 
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get 'home/index'

  namespace :api do
    namespace :v1 do
      resources :reports
      resources :posts
      resources :contacts
      resources :partners
      resources :projects
    end
  end
end
