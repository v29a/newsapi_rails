class Provider < ApplicationRecord
	enum provider_name: [ "NDTV", "India Today", "Zee News", "Times of India", "News 18", "The Hindu", "India TV", "BBC News" ]
end
