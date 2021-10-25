class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      if options[:format].present?
        Date.strptime(value.to_s, options[:format])
      else
        Date.parse(value.to_s)
      end
    rescue Date::Error
      record.errors.add(attribute, :invalid_date)
    end
  end
end
