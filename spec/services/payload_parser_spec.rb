require 'rails_helper'

RSpec.describe PayloadParser do
  shared_examples 'discoverable payload parsers' do
    context "with AirBnB's payload" do
      let(:payload) { load_file_fixture('air_bnb.json') }
      it { is_expected.to eq(PayloadParser::AirBnbParser) }
    end

    context "with Booking's payload" do
      let(:payload) { load_file_fixture('booking.json') }
      it { is_expected.to eq(PayloadParser::BookingParser) }
    end
  end

  describe '.discover' do
    let(:parser) { PayloadParser.discover(payload) }
    subject { parser.class }

    it_behaves_like 'discoverable payload parsers'

    context 'with invalid payload' do
      subject { parser }
      let(:payload) { load_file_fixture('booking_invalid.json') }
      it { is_expected.to eq(nil) }
    end
  end

  describe '.discover!' do
    let(:parser) { PayloadParser.discover!(payload) }
    subject { parser.class }

    it_behaves_like 'discoverable payload parsers'

    context 'with invalid payload' do
      let(:payload) { load_file_fixture('air_bnb_invalid.json') }
      it 'should raise PayloadParser::NoParserError' do
        expect { PayloadParser.discover!(payload) }.to raise_error(PayloadParser::NoParserError)
      end
    end
  end
end
