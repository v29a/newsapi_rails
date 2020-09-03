desc "Fetch All News Feed from India TV News"
task :fetch_india_tv_news => :environment do
	provider_name = RssProvider.find_by("rss_url LIKE '%indiatvnews%'").provider.provider_name
  FetchNewsWorker.perform_in(1.seconds, provider_name)
end