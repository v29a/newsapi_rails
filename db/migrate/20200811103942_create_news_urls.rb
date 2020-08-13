class CreateNewsUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :providers do |t|
      t.string :provider_url
      t.integer :provider_name

      t.timestamps
    end
  end
end
