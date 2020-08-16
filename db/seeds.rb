# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Provider.create(provider_url: "https://zeenews.india.com/rss/india-national-news.xml", provider_name: "Zee News", categroty: "National")
Provider.create(provider_url: "http://feeds.bbci.co.uk/news/video_and_audio/news_front_page/rss.xml?edition=uk", provider_name: "BBC News", categroty:"Top Stories")
Provider.create(provider_url: "https://www.indiatvnews.com/rssnews/topstory.xml", provider_name: "India Tv News", categroty:"Top Stories")
Provider.create(provider_url: "https://feeds.feedburner.com/ndtvnews-top-stories", provider_name: "NDTV News", categroty:"National")
Provider.create(provider_url: "https://www.indiatoday.in/rss/home", provider_name: "India Today", categroty:"National")
Provider.create(provider_url: "https://www.news18.com/rss/india.xml", provider_name: "News 18  News", categroty:"National")
Provider.create(provider_url: "https://www.thehindu.com/news/national/feeder/default.rss", provider_name: "The Hindu News", categroty:"National")
Provider.create(provider_url: "https://timesofindia.indiatimes.com/rssfeedstopstories.cms", provider_name: "Times of India News", categroty: "Top Stories")
