require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    wheres = params.keys.map {|key| "#{key} = ?"}.join(' AND ')
    raw = DBConnection.execute(<<-SQL, *params.values)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{wheres}
    SQL
    parse_all(raw)
  end


end

class SQLObject
  extend Searchable
end
