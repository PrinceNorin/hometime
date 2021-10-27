require 'rails_helper'

RSpec.describe Reservation, type: :model do
  subject(:reservation) { FactoryBot.build(:reservation) }

  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_uniqueness_of(:code) }
  it { is_expected.to validate_presence_of(:start_date) }
  it { is_expected.to validate_presence_of(:end_date) }
  it { is_expected.to validate_numericality_of(:number_of_nights).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:number_of_guests).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:number_of_adults) }
  it { is_expected.to validate_numericality_of(:number_of_children) }
  it { is_expected.to validate_numericality_of(:number_of_infants) }
  it { is_expected.to validate_presence_of(:payout_amount) }
  it { is_expected.to validate_numericality_of(:payout_amount) }
  it { is_expected.to validate_presence_of(:security_amount) }
  it { is_expected.to validate_numericality_of(:security_amount) }
  it { is_expected.to validate_presence_of(:total_amount) }
  it { is_expected.to validate_numericality_of(:total_amount) }
  it { is_expected.to validate_inclusion_of(:status).in_array %w(accepted cancelled) }

  describe '#end_date' do
    it 'should be greater than #start_date' do
      reservation.start_date = '2021-10-25'
      reservation.end_date = '2021-10-26'
      expect(reservation.valid?).to eq(true)
    end

    it 'should not be less than or equal to #start_date' do
      reservation.start_date = '2021-10-25'
      reservation.end_date = '2021-10-25'
      expect(reservation.valid?).to eq(false)

      reservation.start_date = '2021-10-25'
      reservation.end_date = '2021-10-24'
      expect(reservation.valid?).to eq(false)
    end
  end
end
