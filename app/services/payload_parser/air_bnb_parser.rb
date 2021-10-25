class PayloadParser::AirBnbParser
  attr_reader :params

  # Maybe we need a more sophisticated check than this when future payloads were to introduced.
  def self.match?(params)
    params[:reservation_code].present? &&
      (params[:guest] || {})[:email].present?
  end

  def initialize(params)
    @params = params
  end

  def parse
    {
      code: params[:reservation_code],
      start_date: params[:start_date],
      end_date: params[:end_date],
      number_of_nights: params[:nights],
      number_of_guests: params[:guests],
      number_of_adults: params[:adults],
      number_of_children: params[:children],
      number_of_infants: params[:infants],
      status: params[:status],
      currency: params[:currency],
      payout_amount: parse_money(params[:payout_price]),
      security_amount: parse_money(params[:security_price]),
      total_amount: parse_money(params[:total_price]),
      guest: parse_guest_payload
    }
  end

  private

  def parse_guest_payload
    guest_params = params[:guest] || {}

    {
      first_name: guest_params[:first_name],
      last_name: guest_params[:last_name],
      phone: [guest_params[:phone]].compact,
      email: guest_params[:email]
    }
  end

  def parse_money(value)
    # store as cents in db
    (BigDecimal(value.to_s) * 100).to_i
  rescue ArgumentError
    value # let model handle validation
  end
end
