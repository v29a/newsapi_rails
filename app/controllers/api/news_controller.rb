class Api::NewsController < Api::ApplicationController
	def index
		news = News.all
		render json: news
	end

	def category
		news = News.where(category: params[:category])
		render json: news
	end
end