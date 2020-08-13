desc "Fetch All News Feed from News 18"
task :fetch_news_18_news => :environment do
  FetchNewsWorker.perform_in(1.seconds, "News 18")
end