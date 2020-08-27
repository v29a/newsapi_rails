# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Provider.create(provider_url: "https://zeenews.india.com/rss/india-national-news.xml", provider_name: "Zee News", category: "National")
Provider.create(provider_url: "http://feeds.bbci.co.uk/news/video_and_audio/news_front_page/rss.xml?edition=uk", provider_name: "BBC News", category:"Top Stories")
Provider.create(provider_url: "https://www.indiatvnews.com/rssnews/topstory.xml", provider_name: "India Tv News", category:"Top Stories")
Provider.create(provider_url: "https://feeds.feedburner.com/ndtvnews-top-stories", provider_name: "NDTV News", category:"National")
Provider.create(provider_url: "https://www.indiatoday.in/rss/home", provider_name: "India Today", category:"National")
Provider.create(provider_url: "https://www.news18.com/rss/india.xml", provider_name: "News 18  News", category:"National")
Provider.create(provider_url: "https://www.thehindu.com/news/national/feeder/default.rss", provider_name: "The Hindu News", category:"National")
Provider.create(provider_url: "https://timesofindia.indiatimes.com/rssfeedstopstories.cms", provider_name: "Times of India", category: "Top Stories")

Provider.create(provider_url: "https://www.indiatoday.in/rss/1206550", provider_name: "India Today", category: "Sports")
Provider.create(provider_url: "https://timesofindia.indiatimes.com/rssfeeds/4719148.cms", provider_name: "Times of India", category: "Sports")

Role.create(role_name: "Admin", role_description:"It has the all access except creating/updating and deleting a user and assigning role to any user")
Role.create(role_name: "Super Admin", role_description:"It has the all access like creating/updating and deleting a user and assigning role to any user")
Role.create(role_name: "Publisher", role_description:"It has the access to fetch news from Provider URL and can read, write, delete and update the provider url and news")
Role.create(role_name: "Creator", role_description:"It has the access to fetch news from Provider URL and can read the provider url and news")
Role.create(role_name: "Author", role_description:"It has the access to read, creating, updating and deleting the news")
Role.create(role_name: "Editor", role_description:"It has the access to read the news")

User.create(email: "admin@gmail.com", password:"123456", role_id: 1)
User.create(email: "super_admin@gmail.com", password:"123456", role_id: 2)
User.create(email: "publisher@gmail.com", password:"123456", role_id: 3)