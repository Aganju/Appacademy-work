class AnswerChoice < ActiveRecord::Base
  validates :question_id, presence: true
  validates :text, presence: true

  has_many :responses,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: "Response"

  belongs_to :question,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: "Question"

end