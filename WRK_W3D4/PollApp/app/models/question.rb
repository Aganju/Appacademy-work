class Question < ActiveRecord::Base
  validates :poll_id, presence: true
  validates :text, presence: true

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: "AnswerChoice"

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: "Poll"

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def results
    result = {}
    choices = self.answer_choices
      .select("answer_choices.*, COUNT(responses.id) AS frequency")
      .joins("LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id")
      .group("answer_choices.id")
      .where("answer_choices.question_id = ?", self.id)
    choices.each do |choice|
      result[choice.text] = choice.frequency
    end
    result
  end

  # SELECT
  #   answer_choices.*, COUNT(responses.id)
  # FROM
  #   answer_choices
  # LEFT OUTER JOIN
  #   responses ON answer_choices.id = responses.answer_choice_id
  # GROUP BY
  #   answer_choices
  # WHERE
  #   answer_choice.question_id = self.id

end
