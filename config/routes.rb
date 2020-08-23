Rails.application.routes.draw do


  namespace :admin do
      resources :news
      resources :providers do
      collection do
          post 'fetch_data'
        end
      end

      root to: "news#index"
    end
    root 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
  	resources :news do 
  		collection do
  			post 'category'
  		end
  	end
  	
  end
  require 'sidekiq/web'
	mount Sidekiq::Web => '/sidekiq'
end
