require_relative "association_options"

class HasManyOptions < AssociationOptions
  def initialize(name, self_class_name, options = {})

    options_default = {
      foreign_key: "#{self_class_name.to_s.singularize}_id".underscore.to_sym,
      primary_key: :id,
      class_name: "#{name}".singularize.capitalize
    }
    options = options_default.merge(options)

    @foreign_key = options[:foreign_key]
    @class_name = options[:class_name]
    @primary_key = options[:primary_key]
  end
end
