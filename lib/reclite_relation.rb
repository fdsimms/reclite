require_relative 'db_connection'

class RecLiteRelation
  def initialize(model, query_params = {})
    @query_params = query_params
    @model = model
    @included = []
    @results = []
    @query_string = ""
  end

  def where(params)
    @query_params = params.merge(@query_params)
    self
  end

  def eager_load
    @included.each do |inclusion|

    end
  end

  def query_string
    params = @query_params
    where_line = params.map { |key, _| "#{key} = ?" }
    where_line = where_line.join(" AND ")
    @query_string = "SELECT * FROM #{@model.table_name} WHERE #{where_line}"
  end

  def execute_query
    params = @query_params

    @results = DBConnection.execute(query_string, *(params.values))

    @model.parse_all(@results)
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
