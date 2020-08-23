class Api::NewsController < Api::ApplicationController
	def index
		news = News.all
		if news.present?
			render json: news.flatten, status: :ok
		else
			render json: "Try again", status: 404
		end
	end

	def category
		categorised_news = []
		providers = Provider.where(category: params[:category].capitalize)
		providers.each do |provider|
			feeds = News.where(provider_id: provider.id)
			categorised_news.append(feeds)
		end
		if categorised_news.present?
			render json: categorised_news.flatten, status: :ok
		else
			render json: "Try again with different categories", status: 404
		end
	end
end