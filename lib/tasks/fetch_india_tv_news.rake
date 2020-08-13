desc "Fetch All News Feed from India TV News"
task :fetch_india_tv_news => :environment do
  FetchNewsWorker.perform_in(1.seconds, "India TV")
end