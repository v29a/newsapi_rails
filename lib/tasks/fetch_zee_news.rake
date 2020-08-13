desc "Fetch All News Feed from Zee News"
task :fetch_zee_news => :environment do
  FetchNewsWorker.perform_in(1.seconds, "Zee News")
end