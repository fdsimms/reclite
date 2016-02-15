require_relative 'db_connection'
require_relative 'sql_object'
require_relative 'reclite_relation'
require 'byebug'

module Searchable
  def where(params)

    RecLiteRelation.new(self, params)
  end
end

class SQLObject
  extend Searchable
end
