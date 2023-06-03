# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/schedules' do
  path '/schedules' do
    get 'Retrieves schedule list' do
      tags 'Schedules'
      produces 'application/json'

      response '200', 'schedules found' do
        schema type: :array, items: { '$ref' => '#/components/schemas/Schedule' }

        let(:schedule) { create(:schedule) }

        run_test!
      end
    end

    post 'Creates a schedule' do
      tags 'Schedules'

      consumes 'application/json'
      parameter name: :schedule, in: :body, schema: { '$ref' => '#/components/schemas/ScheduleCreate' }

      response '201', 'schedule created' do
        let(:room) { create(:room) }
        let(:schedule) do
          { title: "Schedule #{Time.zone.now}", room_id: room.id, started_at: Time.zone.now,
            ended_at: 1.hour.from_now }
        end

        it 'returns a 201 response' do |example|
          expect { submit_request(example.metadata) }.to change(Schedule, :count).by(1)

          assert_response_matches_metadata(example.metadata)
        end
      end

      response '422', 'invalid request' do
        schema '$ref' => '#/components/schemas/Error'

        let(:schedule) do
          { title: nil, room_id: nil, started_at: Time.zone.now, ended_at: 1.hour.from_now }
        end

        run_test!
      end
    end
  end

  path '/schedules/{id}' do
    get 'Retrieves a schedule' do
      tags 'Schedules'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'schedule found' do
        schema '$ref' => '#/components/schemas/Schedule'

        let(:id) { create(:schedule).id }

        run_test!
      end

      response '404', 'schedule not found' do
        schema '$ref' => '#/components/schemas/Error'

        let(:id) { 'unknown' }

        run_test!
      end
    end

    patch 'Updates a schedule' do
      tags 'Schedules'
      consumes 'application/json'

      parameter name: :id, in: :path, type: :integer

      parameter name: :schedule, in: :body, schema: { '$ref' => '#/components/schemas/ScheduleCreate' }

      let(:id) { create(:schedule).id }

      response '200', 'schedule updated' do
        let(:schedule) do
          { title: "Updated schedule #{Time.zone.now}" }
        end

        run_test!
      end

      response '422', 'invalid request' do
        schema '$ref' => '#/components/schemas/Error'

        let(:schedule) do
          { title: nil }
        end

        run_test!
      end
    end

    delete 'Deletes a schedule' do
      tags 'Schedules'
      consumes 'application/json'

      parameter name: :id, in: :path, type: :integer

      response '204', 'schedule deleted' do
        let(:id) { create(:schedule).id }

        it 'returns a 204 response' do |example|
          expect { submit_request(example.metadata) }.to change { Schedule.where(id:).count }.by(-1)

          assert_response_matches_metadata(example.metadata)
        end
      end

      response '404', 'schedule not found' do
        let(:id) { 'unknown' }

        run_test!
      end
    end
  end
end
