class AssociationOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    class_name.singularize.constantize
  end

  def table_name
    "#{class_name}s".downcase
  end
end
