require_relative 'db_connection'
require_relative 'sql_object'
require_relative 'reclite_relation'
require 'byebug'

module Searchable
  def where(params)
    RecLiteRelation.new(self, params)
  end

  def includes(*associations)
    relation = RecLiteRelation.new(self)
    associations.each do |association|
      relation.eager_load(association)
    end
    relation
  end
end
