desc "Fetch All News Feed from The Hindu"
task :fetch_the_hindu_news => :environment do
	provider_name = Provider.find_by("provider_url LIKE '%thehindu%'").provider_name
  FetchNewsWorker.perform_in(1.seconds, provider_name)
end