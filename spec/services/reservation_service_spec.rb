require 'rails_helper'

RSpec.describe ReservationService do
  let(:service) { ReservationService.new(params) }

  describe '#save!' do
    context 'with valid payload' do
      let(:params) { load_file_fixture('booking.json') }

      it 'should create a new guest record' do
        expect { service.save! }.to change { Guest.count }.by(1)
      end

      it 'should create a new reservation record' do
        expect { service.save! }.to change { Reservation.count }.by(1)
      end
    end

    context 'with invalid payload' do
      let(:params) { load_file_fixture('booking.json') }

      it 'should raise ActiveRecord::RecordInvalid' do
        params[:reservation][:start_date] = 'invalid date'
        params[:reservation][:total_paid_amount_accurate] = 'xxx'

        expect { service.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'update existing reservation' do
      let(:params) { load_file_fixture('air_bnb.json') }
      let!(:guest) do
        FactoryBot.create(:guest, {
          email: 'wayne_woodbridge@bnb.com',
          first_name: 'first name',
          last_name: 'last name'
        })
      end
      let!(:reservation) do
        FactoryBot.create(:reservation, {
          guest: guest,
          code: 'YYY12345678',
          number_of_nights: 1
        })
      end

      it 'should update guest and reservation information' do
        expect(guest.first_name).to eq('first name')
        expect(guest.last_name).to eq('last name')
        expect(reservation.number_of_nights).to eq(1)

        expect { service.save! }.to change { Guest.count }.by(0)
        expect { service.save! }.to change { Reservation.count }.by(0)

        guest.reload
        reservation.reload

        expect(guest.first_name).to eq('Wayne')
        expect(guest.last_name).to eq('Woodbridge')
        expect(reservation.number_of_nights).to eq(4)
      end
    end
  end
end
