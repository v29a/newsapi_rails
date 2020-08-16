desc "Fetch All News Feed from NDTV News"
task :fetch_ndtv_news => :environment do
	provider_name = Provider.find_by("provider_url LIKE '%ndtvnews%'").provider_name
  FetchNewsWorker.perform_in(1.seconds, provider_name)
end