require_relative '../lib/sql_object.rb'
require_relative '../lib/searchable.rb'
require_relative '../lib/associatable.rb'

class Cat < SQLObject
  belongs_to(
    :owner,
    foreign_key: :owner_id,
    class_name: "Human"
    )

end

class Human < SQLObject
  self.table_name = "humans"

end

# c.name = "John"

# puts Cat.table_name
# puts c.name
# puts Cat.columns
# print Cat.where({owner_id: 3})
# print Cat.where({owner_id: 3}).where({name: "Markov"})
print Cat.where({owner_id: 3})[0].owner
