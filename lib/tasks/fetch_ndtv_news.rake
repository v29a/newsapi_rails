desc "Fetch All News Feed from NDTV News"
task :fetch_ndtv_news => :environment do
  FetchNewsWorker.perform_in(1.seconds, "NDTV")
end