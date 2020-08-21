class CreateProviderContents < ActiveRecord::Migration[6.0]
  def change
    create_table :provider_contents do |t|
      t.string :xml

      t.timestamps
    end
  end
end
