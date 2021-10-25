require 'rails_helper'

RSpec.describe Guest, type: :model do
  subject(:guest) { FactoryBot.build(:guest) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_presence_of(:phone) }
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }

  describe '#email' do
    let(:valid_emails) do
      %w(
        user01@example.com
        user.1@example.lp
        user-1@example.co
        user@e-ample.co.uk
      )
    end

    let(:invalid_emails) do
      %w(
        @example.com
        user01.com
        user01@example
      )
    end

    it 'should validate valid email addresses' do
      valid_emails.each do |email|
        guest.email = email
        expect(guest.valid?).to eq(true)
      end
    end

    it 'should invalidate invalid email addresses' do
      invalid_emails.each do |email|
        guest.email = email
        expect(guest.valid?).to eq(false)
      end
    end
  end
end
