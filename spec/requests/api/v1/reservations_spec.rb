require 'swagger_helper'

RSpec.describe 'api/v1/reservations', type: :request do

  path '/api/v1/reservations' do

    post 'create reservation' do
      tags 'Reservations'
      description 'Create or updating a reservation.'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :reservation, in: :body, schema: {
        oneOf: [
          { '$ref' => '#/components/schemas/air_bnb' },
          { '$ref' => '#/components/schemas/booking' }
        ]
      }

      response 200, 'Reservation saved' do
        let(:reservation) { load_file_fixture('booking.json') }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end

      response 422, 'Invalid payload' do
        let(:reservation) { load_file_fixture('air_bnb_invalid.json') }
        run_test!
      end
    end
  end
end
