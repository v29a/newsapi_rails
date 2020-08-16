desc "Fetch All News Feed from News 18"
task :fetch_news_18_news => :environment do
	provider_name = Provider.find_by("provider_url LIKE '%news18%'").provider_name
  FetchNewsWorker.perform_in(1.seconds, provider_name)
end