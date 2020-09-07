class NewsSerializer < ActiveModel::Serializer
  attributes :id, :title, :summary, :published_on, :url, :media, :provider_name, :provider_url,
  	:category

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
end
