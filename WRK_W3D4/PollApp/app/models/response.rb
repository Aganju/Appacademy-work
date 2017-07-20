class Response < ActiveRecord::Base
  validates :answer_choice_id, presence: true
  validates :responder_id, presence: true

  validate :not_author
  validate :not_duplicate_response

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: "AnswerChoice"

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :responder_id,
    class_name: "User"

  has_one :question,
    through: :answer_choice,
    source: :question

  def not_author
    if self.answer_choice.question.poll.author_id == self.responder_id
      self.errors[:answer_choice_id] << "Can't respond to your own poll!"
    end
  end

  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    sibling_responses.exists?(responder_id: self.responder_id)
  end

  def not_duplicate_response
    if respondent_already_answered?
      self.errors[:responder_id] << "Can't answer again!"
    end
  end
end
