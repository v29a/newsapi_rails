module Admin
  class ProvidersController < Admin::ApplicationController
    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #
    # def update
    #   super
    #   send_foo_updated_email(requested_resource)
    # end

    def fetch_data
        provider = Provider.find(params[:format])
        unless provider.provider_url.include?("indiatvnews" ) || provider.provider_url.include?("hindu" ) || provider.provider_url.include?("zee" )
            xml = HTTParty.get(provider.provider_url)
            ProviderContent.create(xml: xml, provider_id: provider.id)
            feeds = xml["rss"]["channel"]["item"]
            feeds.each do |feed|
                if provider.provider_url.include?("indiatoday" )

                    index_of_summary = feed["description"].index("</a>")
                    summary = feed["description"][index_of_summary..].delete_prefix("</a> ")
                    index_of_image = feed["description"].index("src")
                    image_url = feed["description"][(index_of_image+5)..(index_of_summary-4)]
                    News.create(title: feed["title"], summary: summary, 
                    published_on: feed["pubDate"], url: feed["link"], image_url: image_url, 
                    provider_id: provider.id)
                    provider.update(news_updated_at: Time.now.localtime)

                        
                elsif provider.provider_url.include?("news18")
                    index_of_image = feed["description"].index("https")
                    summary_index = feed["description"].index(" />")
                    last_index_of_image = feed["description"].index("jpg")
                    image_url = feed["description"][(index_of_image)..(last_index_of_image)] + "pg"
                    summary = feed["description"][(summary_index+3)..]
                    News.create(title: feed["title"], summary: summary,published_on: feed["pubDate"], url: feed["link"], image_url: image_url, provider_id: provider.id)
                    provider.update(news_updated_at: Time.now.localtime)

                elsif provider.provider_url.include?("bbc")
                    News.create(title: feed["title"], summary: feed["description"], 
                    published_on: feed["pubDate"], url: feed["link"], image_url: feed["fullimage"], 
                    provider_id: provider.id)
                    provider.update(news_updated_at: Time.now.localtime)


                elsif provider.provider_url.include?("ndtv")
                    News.create(title: feed["title"], summary: feed["description"], 
                    published_on: feed["updatedAt"], url: feed["link"], image_url: feed["fullimage"], 
                    provider_id: provider.id)
                    provider.update(news_updated_at: Time.now.localtime)

                    
                elsif provider.provider_url.include?("timesofindia")
                    News.create(title: feed["title"], summary: feed["description"], 
                    published_on: feed["pubdate"], url: feed["link"], image_url: feed["fullimage"], 
                    provider_id: provider.id)
                    provider.update(news_updated_at: Time.now.localtime)


                end
            end
            redirect_to admin_providers_path, alert: "Fetched Successfully "
        end

        unless provider.provider_url.include?("timesofindia" ) || provider.provider_url.include?("ndtv" ) || provider.provider_url.include?("bbc" ) ||
            provider.provider_url.include?("news18") || provider.provider_url.include?("indiatoday") 


            if provider.provider_url.include?("indiatvnews" )
                xml = HTTParty.get(provider.provider_url)
                ProviderContent.create(xml: xml, provider_id: provider.id)

                xml = xml.body
                feeds = Feedjira.parse(xml)
                feeds.entries.each do |feed|
                    index_of_summary = feed.summary.index("</a>")
                    summary = feed.summary[index_of_summary+4..]
                    index_of_image = feed.summary.index("src")
                    image_url = feed.summary[(index_of_image+5)..(index_of_summary-5)]
                    News.create(title: feed.title, summary: summary, 
                    published_on: feed.published, url: feed.url, image_url: image_url, 
                    provider_id: provider.id)

                end
                provider.update(news_updated_at: Time.now.localtime)

            elsif provider.provider_url.include?("thehindu")
                xml = HTTParty.get(provider.provider_url)
                ProviderContent.create(xml: xml, provider_id: provider.id)
                xml = xml.body
                feeds = Feedjira.parse(xml)
                feeds.entries.each do |feed|
                    News.create(title: feed.title, summary: feed.summary.strip, 
                    published_on: feed.published, url: feed.url,provider_id: provider.id)

                end
                provider.update(news_updated_at: Time.now.localtime)

            elsif provider.provider_url.include?("zee")
                xml = HTTParty.get(provider.provider_url)
                ProviderContent.create(xml: xml, provider_id: provider.id)
                xml = xml.body
                feeds = Feedjira.parse(xml)
                feeds.entries.each do |feed|
                    News.create(title: feed.title, summary: feed.summary.strip, 
                    published_on: feed.published, url: feed.url,provider_id: provider.id)

                end
                provider.update(news_updated_at: Time.now.localtime)
            end
            redirect_to admin_providers_path, alert: "Fetched Successfully "

        end

        unless provider.provider_url.include?("timesofindia" ) || provider.provider_url.include?("ndtv" ) || provider.provider_url.include?("bbc" ) ||
            provider.provider_url.include?("news18") || provider.provider_url.include?("indiatoday") ||
                provider.provider_url.include?("indiatvnews") || provider.provider_url.include?("thehindu") ||
                    provider.provider_url.include?("zee")

            xml = HTTParty.get(provider.provider_url)
            ProviderContent.create(xml: xml, provider_id: provider.id)
            xml = xml.body
            feeds = Feedjira.parse(xml)
            feeds.entries.each do |feed|
                News.create(title: feed.title, summary: feed.summary.strip, 
                published_on: feed.published, url: feed.url,provider_id: provider.id)

            end
            provider.update(news_updated_at: Time.now.localtime)
            redirect_to admin_providers_path, alert: "Fetched Successfully "

        end

    end

    # Override this method to specify custom lookup behavior.
    # This will be used to set the resource for the `show`, `edit`, and `update`
    # actions.
    #
    # def find_resource(param)
    #   Foo.find_by!(slug: param)
    # end

    # The result of this lookup will be available as `requested_resource`

    # Override this if you have certain roles that require a subset
    # this will be used to set the records shown on the `index` action.
    #
    # def scoped_resource
    #   if current_user.super_admin?
    #     resource_class
    #   else
    #     resource_class.with_less_stuff
    #   end
    # end

    # Override `resource_params` if you want to transform the submitted
    # data before it's persisted. For example, the following would turn all
    # empty values into nil values. It uses other APIs such as `resource_class`
    # and `dashboard`:
    #
    # def resource_params
    #   params.require(resource_class.model_name.param_key).
    #     permit(dashboard.permitted_attributes).
    #     transform_values { |value| value == "" ? nil : value }
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
