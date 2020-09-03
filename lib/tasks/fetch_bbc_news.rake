desc "Fetch All News Feed from BBC  News"
task :fetch_bbc_news => :environment do
	provider_name = RssProvider.find_by("rss_url LIKE '%bbc%'").provider.provider_name
  FetchNewsWorker.perform_in(1.seconds, provider_name)
end