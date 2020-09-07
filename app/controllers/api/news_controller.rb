class Api::NewsController < ActionController::API
	  include ActionController::Serialization

	def index
		news = News.all
		if news.present?
			render json: news.reverse, each_serializer: NewsSerializer, status: :ok
		else
			render json: "Try again", status: 404
		end
	end

	def category
		category_id = Category.find_by(category_name: params[:category].capitalize)
		
		news = News.where(category_id: category_id)
		render json: news.reverse, each_serializer: NewsSerializer, status: :ok
	end
end