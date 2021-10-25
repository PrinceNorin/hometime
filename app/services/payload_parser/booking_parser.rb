class PayloadParser::BookingParser
  attr_reader :params

  # Maybe we need a more sophisticated check than this when future payloads were to introduced.
  def self.match?(params)
    params = params[:reservation] || {}
    params[:code].present? && params[:guest_email].present?
  end

  def initialize(params)
    @params = params[:reservation]
  end

  def parse
    guest_details = params[:guest_details] || {}

    {
      code: params[:code],
      start_date: params[:start_date],
      end_date: params[:end_date],
      number_of_nights: params[:nights],
      number_of_guests: params[:number_of_guests],
      number_of_adults: guest_details[:number_of_adults],
      number_of_children: guest_details[:number_of_children],
      number_of_infants: guest_details[:number_of_infants],
      status: params[:status_type],
      currency: params[:host_currency],
      payout_amount: parse_money(params[:expected_payout_amount]),
      security_amount: parse_money(params[:listing_security_price_accurate]),
      total_amount: parse_money(params[:total_paid_amount_accurate]),
      guest: parse_guest_payload
    }
  end

  private

  def parse_guest_payload
    {
      first_name: params[:guest_first_name],
      last_name: params[:guest_last_name],
      email: params[:guest_email],
      phone: (params[:guest_phone_numbers] || []).uniq
    }
  end

  def parse_money(value)
    # store as cents in db
    (BigDecimal(value.to_s) * 100).to_i
  rescue ArgumentError
    value # let model handle validation
  end
end
