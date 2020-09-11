class CreateNews < ActiveRecord::Migration[6.0]
  def change
    create_table :news do |t|
      t.string :summary
      t.datetime :published_on
      t.string :title
      t.string :url
      t.string :media_url
      t.string :media_credit
      t.string :news_type
      t.string :question


      t.timestamps
    end
  end
end
