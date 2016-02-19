# RecLite

## Summary

RecLite is a lightweight ORM that implements the core functionality of ActiveRecord, including relations and associations. It was built from the ground up using Ruby.

## SQLObject

* Parent class for all RecLite model objects
* Monkey patches `method_missing` to metaprogram `find_by_` methods for model attributes
* Sends SQL queries to the database using the DBConnection class

## AssociationOptions

* Holds options for `primary_key`, `foreign_key` and `class_name`
* `#table_name` and `#model_class` return the proper table name and model class for `class_name`

### BelongsToOptions

* Metaprograms default options for a `belongs_to` association

### HasManyOptions

* Metaprograms default options for a `has_many` association

## RecLiteRelation

* Allows stacking of 'where' clauses by storing query parameters
* Lazily evaluates ‘where’ clauses to reduce queries by only firing them when needed
* Uses `method_missing` to execute its stored query when an array method is called

## Modules

### Associatable

* Sets up methods for `belongs_to`, `has_many`, and `has_one_through` associations by using `send`
* Instantiates the appropriate AssociationOptions

### Searchable

* Implements `#where`, which returns a RecLiteRelation so that it can be stacked

## Technologies

* Ruby
* [SQLite3][https://github.com/sparklemotion/sqlite3-ruby]
* [ActiveSupport][https://github.com/rails/rails/tree/master/activesupport]
