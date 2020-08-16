class Api::NewsController < Api::ApplicationController
	def index
		news = News.all
		render json: news
	end

	def category
		categorised_news = []
		providers = Provider.where(category: params[:category])
		providers.each do |provider|
			feeds = News.where(provider_id: provider.id)
			categorised_news.append(feeds)
		end
		render json: categorised_news.flatten
	end
end