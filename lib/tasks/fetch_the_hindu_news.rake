desc "Fetch All News Feed from The Hindu"
task :fetch_the_hindu_news => :environment do
	provider_name = RssProvider.find_by("rss_url LIKE '%thehindu%'").provider.provider_name
  FetchNewsWorker.perform_in(1.seconds, provider_name)
end