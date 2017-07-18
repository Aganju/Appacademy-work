require_relative 'questions_database'

class QuestionLike

  attr_reader :id, :question_id, :user_id

  def self.find_by_id(id)
    question_likes = QuestionsDatabase.instance.execute(<<-SQL, id
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?
    SQL
    )
    # debugger
    QuestionLike.new(question_likes.first)
  end

  def self.likers_for_question_id(question_id)
    likers = QuestionsDatabase.instance.execute(<<-SQL, question_id
      SELECT
        users.*
      FROM
        users
      JOIN
        question_likes ON users.id = question_likes.user_id
      WHERE
        question_likes.question_id = ?
    SQL
    )
    # debugger
    likers.map { |liker| User.new(liker) }
  end

  def self.num_likes_for_question_id(question_id)
    count = QuestionsDatabase.instance.execute(<<-SQL, question_id
      SELECT
        COUNT(*) as num
      FROM
        users
      JOIN
        question_likes ON users.id = question_likes.user_id
      WHERE
        question_likes.question_id = ?
    SQL
    )
    count.first['num']
  end

  def self.liked_questions_for_user_id(user_id)
    questions_liked = QuestionsDatabase.instance.execute(<<-SQL, user_id
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_likes ON questions.id = question_likes.question_id
      WHERE
        question_likes.user_id = ?
    SQL
    )
    questions_liked.map { |question_like| Question.new(question_like) }
  end

  def self.most_liked_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_likes ON question_likes.question_id = questions.id
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
