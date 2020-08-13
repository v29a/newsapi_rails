desc "Fetch All News Feed from India Today News"
task :fetch_india_today_news => :environment do
  FetchNewsWorker.perform_in(1.seconds, "India Today")
end