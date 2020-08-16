desc "Fetch All News Feed"
task :fetch_all_news => :environment do
  FetchNewsWorker.perform_in(1.seconds, provider_name)
end