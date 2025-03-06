# An extra validator that makes sure submitting multiple nested attributes
# at once still validates uniqueness on them. Without this, it is possible
# to create an election with multiple options that are exactly the same,
# even though there's a uniqueness constraint on them, because neither has been
# saved yet.
class NestedAttributesUniquenessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, items)
    field = options[:field]
    return if items.map(&field).uniq.size == items.size

    record.errors.add(attribute, "are not unique")
  end
end
