desc "Fetch NDTV News Feed from NDTV News"
task :fetch_ndtv_news => :environment do
	provider_name = RssProvider.find_by("rss_url LIKE '%ndtv%'").provider.provider_name
  FetchNewsWorker.perform_in(1.seconds, provider_name)
end