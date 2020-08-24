class FetchNewsWorker
	include Sidekiq::Worker
		def perform(provider_name)  
		Provider.where(provider_name: provider_name).each do |provider|
			unless provider.provider_url.include?("indiatvnews" ) || provider.provider_url.include?("hindu" ) || provider.provider_url.include?("zee" )
				xml = HTTParty.get(provider.provider_url)
				ProviderContent.create(xml: xml, provider_id: provider.id)
				feeds = xml["rss"]["channel"]["item"]
				feeds.each do |feed|
					if provider.provider_url.include?("indiatoday" )

						index_of_summary = feed["description"].index("</a>")
						summary = feed["description"][index_of_summary..].delete_prefix("</a> ")
						index_of_image = feed["description"].index("src")
						image_url = feed["description"][(index_of_image+5)..(index_of_summary-4)]
						News.create(title: feed["title"], summary: summary, 
						published_on: feed["pubDate"], url: feed["link"], image_url: image_url, 
						provider_id: provider.id)
						provider.update(news_updated_at: Time.now.localtime)


					elsif provider.provider_url.include?("news18")
						index_of_image = feed["description"].index("https")
						summary_index = feed["description"].index(" />")
						last_index_of_image = feed["description"].index("jpg")
						image_url = feed["description"][(index_of_image)..(last_index_of_image)] + "pg"
						summary = feed["description"][(summary_index+3)..]
						News.create(title: feed["title"], summary: summary,published_on: feed["pubDate"], url: feed["link"], image_url: image_url, provider_id: provider.id)
						provider.update(news_updated_at: Time.now.localtime)

					elsif provider.provider_url.include?("bbc")
						News.create(title: feed["title"], summary: feed["description"], 
						published_on: feed["pubDate"], url: feed["link"], image_url: feed["fullimage"], 
						provider_id: provider.id)
						provider.update(news_updated_at: Time.now.localtime)


					elsif provider.provider_url.include?("ndtv")
						News.create(title: feed["title"], summary: feed["description"], 
						published_on: feed["updatedAt"], url: feed["link"], image_url: feed["fullimage"], 
						provider_id: provider.id)
						provider.update(news_updated_at: Time.now.localtime)


					elsif provider.provider_url.include?("timesofindia")
					index_of_image = feed["description"].index("src")
                    last_index_of_image = feed["description"][index_of_image..].index("/>")+index_of_image
                    image_url = feed["description"][(index_of_image+5)..(last_index_of_image-3)]
                    summary_index = feed["description"].index("</a>")
                    summary = feed["description"][(summary_index+4)..]
                    News.create(title: feed["title"], summary: summary, 
                    published_on: feed["pubDate"], url: feed["link"], image_url: image_url, 
                    provider_id: provider.id)
                    provider.update(news_updated_at: Time.now.localtime)
					end
				end
			end

			unless provider.provider_url.include?("timesofindia" ) || provider.provider_url.include?("ndtv" ) || provider.provider_url.include?("bbc" ) ||
			provider.provider_url.include?("news18") || provider.provider_url.include?("indiatoday") 

				if provider.provider_url.include?("indiatvnews" )
					xml = HTTParty.get(provider.provider_url)
					ProviderContent.create(xml: xml, provider_id: provider.id)

					xml = xml.body
					feeds = Feedjira.parse(xml)
					feeds.entries.each do |feed|
						index_of_summary = feed.summary.index("</a>")
						summary = feed.summary[index_of_summary+4..]
						index_of_image = feed.summary.index("src")
						image_url = feed.summary[(index_of_image+5)..(index_of_summary-5)]
						News.create(title: feed.title, summary: summary, 
						published_on: feed.published, url: feed.url, image_url: image_url, 
						provider_id: provider.id)

					end
					provider.update(news_updated_at: Time.now.localtime)

				elsif provider.provider_url.include?("thehindu")
					xml = HTTParty.get(provider.provider_url)
					ProviderContent.create(xml: xml, provider_id: provider.id)
					xml = xml.body
					feeds = Feedjira.parse(xml)
					feeds.entries.each do |feed|
						News.create(title: feed.title, summary: feed.summary.strip, 
						published_on: feed.published, url: feed.url,provider_id: provider.id)

					end
					provider.update(news_updated_at: Time.now.localtime)

				elsif provider.provider_url.include?("zee")
					xml = HTTParty.get(provider.provider_url)
					ProviderContent.create(xml: xml, provider_id: provider.id)
					xml = xml.body
					feeds = Feedjira.parse(xml)
					feeds.entries.each do |feed|
						News.create(title: feed.title, summary: feed.summary.strip, 
						published_on: feed.published, url: feed.url,provider_id: provider.id)
					end
					provider.update(news_updated_at: Time.now.localtime)
				end

			end

			unless provider.provider_url.include?("timesofindia" ) || provider.provider_url.include?("ndtv" ) || provider.provider_url.include?("bbc" ) ||
			provider.provider_url.include?("news18") || provider.provider_url.include?("indiatoday") ||
			provider.provider_url.include?("indiatvnews") || provider.provider_url.include?("thehindu") ||
			provider.provider_url.include?("zee")

				xml = HTTParty.get(provider.provider_url)
				ProviderContent.create(xml: xml, provider_id: provider.id)
				xml = xml.body
				feeds = Feedjira.parse(xml)
				feeds.entries.each do |feed|
					News.create(title: feed.title, summary: feed.summary.strip, 
					published_on: feed.published, url: feed.url,provider_id: provider.id)

				end
				provider.update(news_updated_at: Time.now.localtime)

			end

		end
	end	
end