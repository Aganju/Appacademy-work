class AddIndices < ActiveRecord::Migration
  def change
    add_index(:users, :username, unique: true)
    add_index(:polls, :author_id)
    add_index(:questions, :poll_id)
    add_index(:answer_choices, :question_id)
    add_index(:responses, [:answer_choice_id, :responder_id])
  end
end
