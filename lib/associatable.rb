require_relative "belongs_to_options"
require_relative "has_many_options"

module Associatable
  def association_options
    @association_options ||= {}
    @association_options
  end

  def has_one_through(name, through_name, source_name)
    define_method(name) do
      through_options = self.class.association_options[through_name]
      through_class = through_options.model_class
      source_options = through_class.association_options[source_name]

      through_foreign_key = through_options.send(:foreign_key)
      through_object =
          through_class.where(id: self.send(through_foreign_key)).first

      source_foreign_key = source_options.send(:foreign_key)
      source_options.model_class
        .where(id: through_object.send(source_foreign_key)).first
    end
  end

  def belongs_to(name, options = {})

    options = BelongsToOptions.new(name, options)
    association_options[name] = options

    define_method(name) do
      foreign_key = options.foreign_key
      model_class = options.send(:model_class)
      model_class.where(id: self.send(foreign_key)).first
    end
  end

  def has_many(name, options = {})
    self_class_name = "#{self.to_s.underscore.singularize}".to_sym
    options = HasManyOptions.new(name, self_class_name, options)

    define_method(name) do
      foreign_key = options.foreign_key
      model_class = options.send(:model_class)
      where_options = {}
      where_options[foreign_key] = self.id

      model_class.where(where_options)
    end
  end

end
