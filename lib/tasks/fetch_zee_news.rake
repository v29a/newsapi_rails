desc "Fetch All News Feed from Zee News"
task :fetch_zee_news => :environment do
	provider_name = RssProvider.find_by("rss_url LIKE '%zeenews%'").provider.provider_name
  FetchNewsWorker.perform_in(1.seconds, provider_name)
end