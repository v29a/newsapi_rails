class FetchNewsWorker
  include Sidekiq::Worker

  def perform(provider_name)
    Provider.where(provider_name: provider_name).each do |provider|
			xml = HTTParty.get(provider.provider_url).body
			feeds = Feedjira.parse(xml)
			feeds.entries.each do |feed|
				News.create(category: feeds.title, title: feed.title, summary: feed.summary, 
					published_on: feed.published, url: feed.url)
			end
		end
  end
end
