require_relative '../lib/sql_object.rb'
require_relative '../lib/searchable.rb'
require_relative '../lib/associatable.rb'

class Cat < SQLObject
  attr_accessor :name, :owner_id, :id
  belongs_to(
    :owner,
    foreign_key: :owner_id,
    class_name: "Human"
    )

end

class Human < SQLObject
  attr_accessor :id, :fname, :lname, :house_id
  self.table_name = "humans"

end

# c.name = "John"

# puts Cat.table_name
# puts c.name
# puts Cat.columns
# print Cat.where({owner_id: 3})
# print Cat.where({owner_id: 3}).where({name: "Markov"})
print Cat.where({owner_id: 3})[0].owner
