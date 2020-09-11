class AddQuestionAnswerForiegnKeys < ActiveRecord::Migration[6.0]
  def change
  	add_reference :questions, :news, foriegn_key: true 
  	add_reference :answers, :question, foriegn_key: true 

  end
end
