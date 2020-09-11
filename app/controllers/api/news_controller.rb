class Api::NewsController < ActionController::API
	  include ActionController::Serialization
	  before_action :show_news, only: [:show, :show_question, :ans_question, :news_score]

	def index
		news = News.all
		if news.present?
			render json: news.reverse, each_serializer: NewsSerializer, status: :ok
		else
			render json: "Try again", status: 404
		end
	end

	def show
		if @news.present?																																																						
			render json: @news, serializer: NewsSerializer, status: :ok
		else
			render json: "Try again", status: 404
		end
	end

	def category
		category_id = Category.find_by(category_name: params[:category].capitalize)
		
		news = News.where(category_id: category_id)
		render json: news.reverse, each_serializer: NewsSerializer, status: :ok
	end

	def show_question
		render json: @news.question, status: :ok
	end

	def ans_question
		Answer.create(answer_name: params[:answer].downcase, question_id: @news.question.id)
		render json: {message:"Answer Submitted", status: :ok}
	end

	def news_score
		total = @news.question.answers.size
		if @news.question.answer_type.downcase.include?("yes") 
			yes = (@news.question.answers.where(answer_name: "yes" ).size*100)/total
			no = (@news.question.answers.where(answer_name: "no").size*100)/total
		elsif @news.question.answer_type.downcase.include?("true")
			yes = (@news.question.answers.where(answer_name: "true" ).size*100)/total
			no = (@news.question.answers.where(answer_name: "false").size*100)/total
		end
		render json: {yes: yes, no: no, status: :ok}

	end

	private
	def show_news
		@news = News.find(params[:id])
	end
end