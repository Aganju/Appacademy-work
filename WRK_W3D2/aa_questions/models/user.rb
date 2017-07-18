require_relative 'questions_database'

class User

  attr_reader :id
  attr_accessor :fname, :lname

  def self.find_by_id(id)
    user = QuestionsDatabase.instance.execute(<<-SQL, id
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL
    )
    # debugger
    User.new(user.first)
  end

  def self.find_by_name(fname, lname)
    user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL
    )
    # debugger
    User.new(user.first)
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def save
    if @id
      QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname, @id
        UPDATE
          users
        SET
          fname = ?, lname = ?
        WHERE
          id = ?
      SQL
      )
    else
      QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname
        INSERT INTO
          users(fname, lname)
        VALUES
        ( ? , ? )
      SQL
      )
      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    average = QuestionsDatabase.instance.execute(<<-SQL, @id
      SELECT
        AVG(user_question_likes.num_likes) as avg
      FROM (SELECT
        COUNT(question_likes.question_id) as num_likes
      FROM
        questions
      LEFT OUTER JOIN
        question_likes  ON questions.id = question_likes.question_id
      WHERE
        questions.author_id = ?
      GROUP BY
        questions.id) as user_question_likes
    SQL
    )

    average.first['avg']
  end

end

USER_TEST = {
  'fname' => 'Melania',
  'lname' => 'Trump'
}
