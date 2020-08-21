class CreateNewsUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :providers do |t|
      t.string :provider_url, unique: true
      t.string :provider_name
      t.string :category
      t.datetime :news_updated_at
      t.timestamps
    end
  end
end
