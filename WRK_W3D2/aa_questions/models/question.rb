require_relative 'questions_database'

class Question

  attr_reader :id, :author_id
  attr_accessor :title, :body

  def self.find_by_id(id)
    question = QuestionsDatabase.instance.execute(<<-SQL, id
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL
    )
    return nil if question.count < 1
    # debugger
    Question.new(question.first)
  end

  def self.find_by_author_id(author_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, author_id
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?
    SQL
    )
    # debugger
    questions.map { |question| Question.new(question) }
  end

  def self.most_followed(n = 1)
    QuestionFollow.most_followed_questions(n)
  end

  def self.most_liked(n = 1)
    QuestionLike.most_liked_questions(n)
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def save
    if @id
      QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author_id, @id
        UPDATE
          questions
        SET
          title = ?, body = ?, author_id = ?
        WHERE
          id = ?
      SQL
      )
    else
      QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author_id
        INSERT INTO
          questions(title, body, author_id)
        VALUES
        ( ? , ?, ? )
      SQL
      )
      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end

  def author
    author = QuestionsDatabase.instance.execute(<<-SQL, @author_id
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL
    )
    User.new(author)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

end

QUESTION_TEST = {
  'title' => 'How to get a divorce',
  'body' => "I need to leave marraige but he just stares at my boobs",
  'author_id' => 6
}
