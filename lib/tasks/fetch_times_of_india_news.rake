desc "Fetch All News Feed from Times of India"
task :fetch_times_of_india_news => :environment do
  FetchNewsWorker.perform_in(1.seconds, "Times of India")
end