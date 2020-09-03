desc "Fetch All News Feed from India Today News"
task :fetch_india_today_news => :environment do
	provider_name = RssProvider.find_by("rss_url LIKE '%indiatoday%'").provider.provider_name
  FetchNewsWorker.perform_in(1.seconds, provider_name)
end