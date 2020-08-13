desc "Fetch All News Feed from BBC  News"
task :fetch_bbc_news => :environment do
  FetchNewsWorker.perform_in(1.seconds, "BBC News")
end