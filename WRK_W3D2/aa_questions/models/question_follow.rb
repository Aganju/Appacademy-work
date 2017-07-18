

class QuestionFollow < ModelBase

  TABLE_NAME = 'question_follows'

  attr_reader :id, :question_id, :user_id

  def self.followers_for_question_id(question_id)
    followers = QuestionsDatabase.instance.execute(<<-SQL, question_id
      SELECT
        users.*
      FROM
        users
      Join
        question_follows ON question_follows.user_id = users.id
      WHERE
        question_id = ?
    SQL
    )
    followers.map { |follower| User.new(follower) }
  end

  def self.followed_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id
      SELECT
        questions.*
      FROM
        questions
      Join
        question_follows ON question_follows.question_id = questions.id
      WHERE
        question_follows.user_id = ?
    SQL
    )
    questions.map { |question| Question.new(question) }
  end

  def self.most_followed_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_follows ON question_follows.question_id = questions.id
      GROUP BY
        question_id
      HAVING
        COUNT(*) >= 1
      ORDER BY
        COUNT(*) DESC
      LIMIT
        ?
    SQL
    )
    questions.map { |question| Question.new(question) }
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

end
