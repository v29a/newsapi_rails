class CreateNews < ActiveRecord::Migration[6.0]
  def change
    create_table :news do |t|
      t.string :summary
      t.datetime :published_on
      t.string :title
      t.string :url
      t.string :image_url

      t.timestamps
    end
  end
end
