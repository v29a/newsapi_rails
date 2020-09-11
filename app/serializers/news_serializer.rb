class NewsSerializer < ActiveModel::Serializer
  attributes :id, :title, :summary, :published_on, :url, :media, :provider_name, :provider_url,
  	:category, :media_credit, :question, :question_type

  private 
  def media
  	if object.media.present?
  		object.media.service_url
  	else
  		object.media_url
  	end
  end

  def provider_name
  	return object.provider_id.present? ? object.provider.provider_name : ""
  end

  def provider_url
  	return object.provider_id.present? ? object.provider.provider_url : ""
  end

  def category
  	object.category.category_name
  end

  def question
    return object.question.present? ? object.question.question_name : ""
    
  end

  def question_type
    return object.question.present? ? object.question.answer_type : ""    
  end
end
