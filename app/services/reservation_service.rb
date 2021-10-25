class ReservationService
  attr_reader :payload_parser

  def initialize(params)
    @payload_parser = PayloadParser.discover!(params)
  end

  def save!
    payload = payload_parser.parse
    guest_params = payload.delete(:guest)

    guest = Guest.find_by(email: guest_params[:email])
    if guest.present?
      guest.assign_attributes(guest_params)
    else
      guest = Guest.new(guest_params)
    end

    reservation = Reservation.find_by(code: payload[:code])
    if reservation.present?
      reservation.assign_attributes(payload)
    else
      reservation = Reservation.new(payload)
    end

    Reservation.transaction do
      guest.save!
      reservation.guest = guest
      reservation.save!
    end

    { reservation: reservation, guest: guest }
  end
end
