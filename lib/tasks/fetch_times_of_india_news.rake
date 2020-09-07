desc "Fetch All News Feed from Times of India"
task :fetch_times_of_india_news => :environment do
	provider_name = RssProvider.find_by("rss_url LIKE '%timesofindia%'").provider.provider_name

  FetchNewsWorker.perform_in(1.seconds, provider_name)
end