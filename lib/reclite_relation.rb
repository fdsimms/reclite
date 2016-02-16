require_relative 'db_connection'

class RecLiteRelation
  attr_accessor :query_string, :query_params, :included_models

  def initialize(model, query_params = {})
    @query_params = query_params
    @model = model
    @included_models = []
    @results = []
    @query_string = "SELECT * FROM #{@model.table_name} AS t1"
  end

  def where(params)
    query_params = params.merge(query_params)
    self
  end

  def eager_load(association)
    association_options = @model.association_options[association]
    assoc_model_class = association_options.model_class
    assoc_table_name = association_options.table_name
    table_name = @model.table_name
    foreign_key = association_options.foreign_key

    self.included_models << assoc_model_class

    self.query_string += " LEFT OUTER JOIN #{assoc_table_name} AS t2 "
    self.query_string += "ON t2.id = t1.#{foreign_key}"
  end

  def query_string
    if query_params.empty?
      @query_string
    else
      params = @query_params
      where_line = params.map { |key, _| "#{key} = ?" }
      where_line = where_line.join(" AND ")
        @query_string += " WHERE #{where_line}"
      @query_string
    end
  end

  def execute_query
    params = @query_params
    @results = DBConnection.execute(query_string, *(params.values))
    if included_models.empty?
      @model.parse_all(@results)
    end
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
