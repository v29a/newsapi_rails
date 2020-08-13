desc "Fetch All News Feed from The Hindu"
task :fetch_the_hindu_news => :environment do
  FetchNewsWorker.perform_in(1.seconds, "The Hindu")
end