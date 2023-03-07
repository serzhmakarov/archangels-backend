Rails.application.routes.draw do
  devise_for :users
  get 'home/index'

  namespace :api do
    namespace :v1 do
      post 'register', to: 'auth#register'
      post 'login', to: 'auth#login'
      delete 'logout', to: 'auth#logout'
    end
  end
  
  namespace :api do
    namespace :v1 do
      resources :reports
    end
  end

  namespace :api do
    namespace :v1 do
      resources :posts
    end
  end

  namespace :api do
    namespace :v1 do
      resources :contacts
    end
  end
end
