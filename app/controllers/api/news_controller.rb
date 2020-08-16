class Api::NewsController < Api::ApplicationController
	def index
		news = News.all
		render json: news
	end

	def category
		categorised_news = []
		provider_ids = Provider.where(category: params[:category].ids
		provider_ids.each do |provider_id|
			feeds = News.where(provider_id: provider_id)
			categorised_news.append(feeds)
		end
		render json: categorised_news
	end
end