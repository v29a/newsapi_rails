class FetchNewsWorker
	include Sidekiq::Worker
	def perform(provider_name)  
		Provider.where(provider_name: provider_name).each do |provider|
			provider.rss_providers.each do |rss_provider|
        	unless rss_provider.rss_url.include?("indiatvnews" ) || rss_provider.rss_url.include?("hindu" ) || rss_provider.rss_url.include?("zee" )
	            xml = HTTParty.get(rss_provider.rss_url)
	            ProviderContent.create(xml: xml, rss_provider_id: rss_provider.id)
	            feeds = xml["rss"]["channel"]["item"]
	            feeds.each do |feed|
	                if rss_provider.rss_url.include?("indiatoday" )

	                    index_of_summary = feed["description"].index("</a>")
	                    summary = feed["description"][index_of_summary..].delete_prefix("</a> ")
	                    index_of_image = feed["description"].index("src")
	                    image_url = feed["description"][(index_of_image+5)..(index_of_summary-4)]
	                    News.create(title: feed["title"], summary: summary, 
	                    published_on: feed["pubDate"], url: feed["link"], image_url: image_url, 
	                    rss_provider_id: rss_provider.id, category_id: rss_provider.category.id)
	                    rss_provider.update(news_updated_at: Time.now.localtime)

	                        
	                elsif rss_provider.rss_url.include?("news18")
	                    index_of_image = feed["description"].index("https")
	                    summary_index = feed["description"].index(" />")
	                    last_index_of_image = feed["description"].index("jpg")
	                    image_url = feed["description"][(index_of_image)..(last_index_of_image)] + "pg"
	                    summary = feed["description"][(summary_index+3)..]
	                    News.create(title: feed["title"], summary: summary,published_on: feed["pubDate"], url: feed["link"], image_url: image_url, rss_provider_id: rss_provider.id, category_id: rss_provider.category.id)
	                    rss_provider.update(news_updated_at: Time.now.localtime)

	                elsif rss_provider.rss_url.include?("bbc")
	                    News.create(title: feed["title"], summary: feed["description"], 
	                    published_on: feed["pubDate"], url: feed["link"], image_url: feed["fullimage"], 
	                    rss_provider_id: rss_provider.id, category_id: rss_provider.category.id)
	                    rss_provider.update(news_updated_at: Time.now.localtime)


	                elsif rss_provider.rss_url.include?("ndtv")
	                    News.create(title: feed["title"], summary: feed["description"], 
	                    published_on: feed["updatedAt"], url: feed["link"], image_url: feed["fullimage"], 
	                    rss_provider_id: rss_provider.id)
	                    rss_provider.update(news_updated_at: Time.now.localtime)

	                    
	                elsif rss_provider.rss_url.include?("timesofindia")
	                    if rss_provider.category == "Sports"
	                        index_of_image = feed["description"].index("src")
	                        last_index_of_image = feed["description"][index_of_image..].index("/>")+index_of_image
	                        image_url = feed["description"][(index_of_image+5)..(last_index_of_image-3)]
	                        summary_index = feed["description"].index("</a>")
	                        summary = feed["description"][(summary_index+4)..]
	                        News.create(title: feed["title"], summary: summary, 
	                        published_on: feed["pubDate"], url: feed["link"], image_url: image_url, 
	                        rss_provider_id: rss_provider.id, category_id: rss_provider.category.id)
	                        rss_provider.update(news_updated_at: Time.now.localtime)
	                    else
	                        News.create(title: feed["title"], summary: feed["description"], 
	                        published_on: feed["pubDate"], url: feed["link"], image_url: "", 
	                        rss_provider_id: rss_provider.id)
	                        rss_provider.update(news_updated_at: Time.now.localtime, category_id: rss_provider.category.id)
	                    end
	                end
	            end
	        end

	        unless rss_provider.rss_url.include?("timesofindia" ) || rss_provider.rss_url.include?("ndtv" ) || rss_provider.rss_url.include?("bbc" ) ||
	            rss_provider.rss_url.include?("news18") || rss_provider.rss_url.include?("indiatoday") 


	            if rss_provider.rss_url.include?("indiatvnews" )
	                xml = HTTParty.get(rss_provider.rss_url)
	                ProviderContent.create(xml: xml, rss_provider_id: rss_provider.id)

	                xml = xml.body
	                feeds = Feedjira.parse(xml)
	                feeds.entries.each do |feed|
	                    index_of_summary = feed.summary.index("</a>")
	                    summary = feed.summary[index_of_summary+4..]
	                    index_of_image = feed.summary.index("src")
	                    image_url = feed.summary[(index_of_image+5)..(index_of_summary-5)]
	                    News.create(title: feed.title, summary: summary, 
	                    published_on: feed.published, url: feed.url, image_url: image_url, 
	                    rss_provider_id: rss_provider.id, category_id: rss_provider.category.id)

	                end
	                rss_provider.update(news_updated_at: Time.now.localtime)

	            elsif rss_provider.rss_url.include?("thehindu")
	                xml = HTTParty.get(rss_provider.rss_url)
	                ProviderContent.create(xml: xml, rss_provider_id: rss_provider.id)
	                xml = xml.body
	                feeds = Feedjira.parse(xml)
	                feeds.entries.each do |feed|
	                    News.create(title: feed.title, summary: feed.summary.strip, 
	                    published_on: feed.published, url: feed.url,rss_provider_id: rss_provider.id, category_id: rss_provider.category.id)

	                end
	                rss_provider.update(news_updated_at: Time.now.localtime)

	            elsif rss_provider.rss_url.include?("zee")
	                xml = HTTParty.get(rss_provider.rss_url)
	                ProviderContent.create(xml: xml, rss_provider_id: rss_provider.id)
	                xml = xml.body
	                feeds = Feedjira.parse(xml)
	                feeds.entries.each do |feed|
	                    News.create(title: feed.title, summary: feed.summary.strip, 
	                    published_on: feed.published, url: feed.url,rss_provider_id: rss_provider.id, category_id: rss_provider.category.id)

	                end
	                rss_provider.update(news_updated_at: Time.now.localtime)
	            end

	        end

	      unless rss_provider.rss_url.include?("timesofindia" ) || rss_provider.rss_url.include?("ndtv" ) || rss_provider.rss_url.include?("bbc" ) ||
	        rss_provider.rss_url.include?("news18") || rss_provider.rss_url.include?("indiatoday") ||
	          rss_provider.rss_url.include?("indiatvnews") || rss_provider.rss_url.include?("thehindu") ||
	            rss_provider.rss_url.include?("zee")

	        xml = HTTParty.get(rss_provider.rss_url)
	        ProviderContent.create(xml: xml, rss_provider_id: rss_provider.id)
	        xml = xml.body
	        feeds = Feedjira.parse(xml)
	        feeds.entries.each do |feed|
	          News.create(title: feed.title, summary: feed.summary.strip, 
	          published_on: feed.published, url: feed.url,rss_provider_id: rss_provider.id, category_id: rss_provider.category.id)

	        end
	       	rss_provider.update(news_updated_at: Time.now.localtime)
	      end
			end
		end
	end	
end