class FetchNewsWorker
  include Sidekiq::Worker

  def perform(provider_name)
    Provider.where(provider_name: provider_name).each do |provider|
			xml = HTTParty.get(provider.provider_url).body
			feeds = Feedjira.parse(xml)
			feeds.entries.each do |feed|
				if provider.provider_url.include?("indiatoday" )
					index_of_summary = feed.summary.index("</a>")
					summary = feed.summary[index_of_summary..].delete_prefix("</a> ")
					index_of_image = feed.summary.index("src")
					image_url = feed.summary[(index_of_image+5)..(index_of_summary-4)]
					News.create(title: feed.title, summary: summary,published_on: feed.published, url: feed.url, image_url: image_url, provider_id: provider.id)
				elsif provider.provider_url.include?("indiatvnews" )
					index_of_summary = feed.summary.index("</a>")
					summary = feed.summary[index_of_summary..].delete_prefix("</a> ")
					index_of_image = feed.summary.index("src")
					image_url = feed.summary[(index_of_image+5)..(index_of_summary-4)]
					News.create(title: feed.title, summary: summary,published_on: feed.published, url: feed.url, image_url: image_url, provider_id: provider.id)		
				else
					News.create(title: feed.title, summary: feed.summary, 
					published_on: feed.published, url: feed.url, provider_id: provider.id)
				end
			end
		end
  end	
end