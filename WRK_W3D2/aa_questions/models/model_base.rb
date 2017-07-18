
require 'byebug'
class ModelBase

  def self.find_by_id(id)
    model = QuestionsDatabase.instance.execute(<<-SQL, id
      SELECT
        *
      FROM
        #{self::TABLE_NAME}
      WHERE
        id = ?
    SQL
    )
    return nil if model.count < 1
    self.new(model.first)
  end

  def save
    var_hash = Hash.new
    variables = self.instance_variables
    variables.each { |var| var_hash[var[1..-1].to_sym] = self.instance_variable_get(var) }
    variables.delete(:@id)
    set_params = variables.map(&:to_s).map do |var|
      var = var[1..-1]+ ' = :'+var[1..-1]
    end.join(", ")


    if var_hash[:id]
      QuestionsDatabase.instance.execute(<<-SQL,var_hash)
        UPDATE
          #{self.class::TABLE_NAME}
        SET
          #{set_params}
        WHERE
          id = :id
      SQL
    else
      var_hash.delete(:id)
      debugger
      QuestionsDatabase.instance.execute(<<-SQL, var_hash)
          INSERT INTO
            #{self.class::TABLE_NAME}#{variables.map { |var| var.to_s[1..-1] }.join(', ')}
          VALUES
            #{variables.join(', ')}
      SQL

      true
      # @id = QuestionsDatabase.instance.last_insert_row_id
    end
  end


end
#
# quest = Question.find_by_id(1)
# quest.title = "New Title"
# quest.save
