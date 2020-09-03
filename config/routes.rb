Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/cable'
  mount Notifications::Engine => "/notifications"
  

  devise_for :users, controllers: { sessions: 'users/sessions' }
  namespace :admin do

      resources :news
      resources :users
      resources :roles
      resources :categories
      resources :providers
      
      resources :rss_providers do
      collection do
          post 'fetch_data'
        end
      end
      root to: "news#index"
    end
    root to: 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
  	resources :news do 
  		collection do
  			post 'category'
  		end
  	end
  	
  end
end
