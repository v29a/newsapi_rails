class CreateRssProviders < ActiveRecord::Migration[6.0]
  def change
    create_table :rss_providers do |t|
      t.string :rss_url
      t.datetime :news_updated_at
      t.timestamps
    end
  end
end
