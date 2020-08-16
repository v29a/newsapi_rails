desc "Fetch All News Feed from BBC  News"
task :fetch_bbc_news => :environment do
	provider_name = Provider.find_by("provider_url LIKE '%bbc%'").provider_name
  FetchNewsWorker.perform_in(1.seconds, provider_name)
end