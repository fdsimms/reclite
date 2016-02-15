require_relative "association_options"

class BelongsToOptions < AssociationOptions
  def initialize(name, options = {})

    options_default = {
      foreign_key: "#{name.to_s.singularize}_id".underscore.to_sym,
      primary_key: :id,
      class_name: "#{name}".singularize.capitalize
    }
    options = options_default.merge(options)

    @foreign_key = options[:foreign_key]
    @class_name = options[:class_name]
    @primary_key = options[:primary_key]
  end
end
