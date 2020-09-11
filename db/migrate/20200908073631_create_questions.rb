class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :question_name
      t.string :answer_type
      t.string :news_title
      t.timestamps
    end
  end
end
