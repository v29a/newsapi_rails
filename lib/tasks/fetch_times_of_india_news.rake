desc "Fetch All News Feed from Times of India"
task :fetch_times_of_india_news => :environment do
	provider_name = Provider.find_by("provider_url LIKE '%timesofindia%'").provider_name
  FetchNewsWorker.perform_in(1.seconds, provider_name)
end