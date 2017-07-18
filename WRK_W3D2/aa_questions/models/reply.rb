
class Reply < ModelBase

  TABLE_NAME = 'replies'

  attr_reader :id, :author_id, :question_id, :parent_id
  attr_accessor :body

  def self.find_by_user_id(user_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, user_id
      SELECT
        *
      FROM
        replies
      WHERE
        author_id = ?
    SQL
    )
    # debugger
    replies.map { |reply| Reply.new(reply) }
  end

  def self.find_by_question_id(question_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, question_id
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL
    )
    # debugger
    replies.map { |reply| Reply.new(reply) }
  end

  def initialize(options)
    @id = options['id']
    @parent_id = options['parent_id']
    @question_id = options['question_id']
    @body = options['body']
    @author_id = options['author_id']
  end

  def save
    if @id
      QuestionsDatabase.instance.execute(<<-SQL, @body, @id
        UPDATE
          replies
        SET
          body = ?
        WHERE
          id = ?
      SQL
      )
    else
      QuestionsDatabase.instance.execute(<<-SQL, @parent_id, @question_id, @body, @author_id
        INSERT INTO
          replies(parent_id, question_id, body, author_id)
        VALUES
        ( ?, ?, ?, ? )
      SQL
      )
      @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end

  def author
    User.find_by_id(@author_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_id)
  end

  def child_replies
    replies = QuestionsDatabase.instance.execute(<<-SQL, @id
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL
    )
    replies.map { |reply| Reply.new(reply) }
  end
end

REPLY_TEST = {
  'parent_id' => 1,
  'question_id' => 1,
  'body' => "I don't know but i'm the best",
  'author_id' => 4
}
