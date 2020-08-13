# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

every 1.day, :at => '9:55 am' do
  rake "fetch_zee_news"
end

every 1.day, :at => '10:17 am' do
  rake "fetch_india_today_news"
end

every 1.day, :at => '10:24 am' do
  rake "fetch_ndtv_news"
end

every 1.day, :at => '10:55 am' do
  rake "fetch_bbc_news"
end

every 1.day, :at => '11:24 am' do
  rake "fetch_news_18_news"
end

every 1.day, :at => '12:28 am' do
  rake "fetch_the_hindu_news"
end

every 1.day, :at => '06:24 am' do
  rake "fetch_times_of_india_news"
end

every 1.day, :at => '08:45 am' do
  rake "fetch_india_tv_news"
end

# Learn more: http://github.com/javan/whenever
