require_relative 'db_connection'

class RecLiteRelation
  #stores SQL queries
  #has method to call queries
  #where usually returns one of these
  #method_missing calls the missing method on the result of calling the
  #relation call method
  def initialize(model, query_params = {})
    @query_params = query_params
    @model = model
  end

  def where(params)
    @query_params = params.merge(@query_params)
    self
  end

  def execute_query
    params = @query_params
    where_line = params.map { |key, _| "#{key} = ?" }
    where_line = where_line.join(" AND ")
    results = DBConnection.execute(<<-SQL, *(params.values))
      SELECT * FROM #{@model.table_name} WHERE #{where_line}
    SQL

    @model.parse_all(results)
  end

  def method_missing(method_name, *args)
    if args.length === 0
      execute_query.send(method_name)
    elsif args.length === 1
      execute_query.send(method_name, args.first)
    else
      execute_query.send(method_name, *args)
    end
  end
end
