Rails.application.routes.draw do
  get 'home/index'
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
