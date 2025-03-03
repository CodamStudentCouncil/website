class CampusValidator < ActiveModel::Validator
  def validate(record)
    unless ENV.fetch("CAMPUS_ID").to_i.in? record.campus_ids
      record.errors.add :username, "is not a student at this campus"
    end
  end
end
