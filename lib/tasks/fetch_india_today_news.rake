desc "Fetch All News Feed from India Today News"
task :fetch_india_today_news => :environment do
	provider_name = Provider.find_by("provider_url LIKE '%indiatoday%'").provider_name
  FetchNewsWorker.perform_in(1.seconds, provider_name)
end