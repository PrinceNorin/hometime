require 'rails_helper'

RSpec.describe PayloadParser::BookingParser do
  describe '.match?' do
    subject { PayloadParser::BookingParser.match?(payload) }

    context 'with valid payload' do
      let(:payload) { load_file_fixture('booking.json') }
      it { is_expected.to eq(true) }
    end

    context 'with invalid payload' do
      let(:payload) { load_file_fixture('booking_invalid.json') }
      it { is_expected.to eq(false) }
    end
  end

  describe '#parse' do
    let(:service) { PayloadParser::BookingParser.new(payload) }
    let(:payload) { load_file_fixture('booking.json') }
    let(:result) do
      {
        code: 'XXX12345678',
        start_date: '2021-03-12',
        end_date: '2021-03-16',
        number_of_nights: 4,
        number_of_guests: 4,
        number_of_adults: 2,
        number_of_children: 2,
        number_of_infants: 0,
        status: 'accepted',
        guest: {
          first_name: 'Wayne',
          last_name: 'Woodbridge',
          phone: ['639123456789'],
          email: 'wayne_woodbridge@bnb.com'
        },
        currency: 'AUD',
        payout_amount: 380000,
        security_amount: 50000,
        total_amount: 430000
      }
    end

    it 'should return payload with uniform structure' do
      expect(service.parse).to eq(result)
    end
  end
end
