desc "Fetch All News Feed from India TV News"
task :fetch_india_tv_news => :environment do
	provider_name = Provider.find_by("provider_url LIKE '%indiatvnews%'").provider_name
  FetchNewsWorker.perform_in(1.seconds, provider_name)
end