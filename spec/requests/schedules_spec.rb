# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/schedules' do
  path '/schedules' do
    get 'Retrieves schedule list' do
      tags 'Schedules'
      produces 'application/json'

      request_body_example value: [{
        id: 1,
        title: 'Schedule 1',
        start_time: Time.zone.now,
        end_time: 1.hour.from_now,
        created_at: Time.zone.now,
        updated_at: Time.zone.now
      }], summary: 'Schedule example list'

      response '200', 'schedules found' do
        schema type: :array,
               items: {
                 properties: {
                   id: { type: :integer },
                   title: { type: :string },
                   room_id: { type: :integer },
                   start_time: { type: :string, format: :'date-time' },
                   end_time: { type: :string, format: :'date-time' },
                   created_at: { type: :string, format: :'date-time' },
                   updated_at: { type: :string, format: :'date-time' }
                 },
                 required: %w[id title start_time end_time created_at updated_at]
               }

        let(:schedule) { create(:schedule) }

        run_test!
      end
    end

    post 'Creates a schedule' do
      tags 'Schedules'

      consumes 'application/json'
      parameter name: :schedule, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          room_id: { type: :integer },
          start_time: { type: :string, format: :'date-time' },
          end_time: { type: :string, format: :'date-time' }
        },
        required: %w[title start_time end_time]
      }

      response '201', 'schedule created' do
        let(:room) { create(:room) }
        let(:schedule) do
          { title: "Schedule #{Time.zone.now}", room_id: room.id, start_time: Time.zone.now,
            end_time: 1.hour.from_now }
        end

        it 'returns a 201 response' do |example|
          expect { submit_request(example.metadata) }.to change(Schedule, :count).by(1)

          assert_response_matches_metadata(example.metadata)
        end
      end

      response '422', 'invalid request' do
        let(:schedule) do
          { title: nil, room_id: nil, start_time: Time.zone.now, end_time: 1.hour.from_now }
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

      request_body_example value: { some_field: 'Foo' }, name: 'basic', summary: 'Request example description'

      response '200', 'schedule found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 title: { type: :string },
                 room_id: { type: :integer },
                 start_time: { type: :string, format: :'date-time' },
                 end_time: { type: :string, format: :'date-time' },
                 created_at: { type: :string, format: :'date-time' },
                 updated_at: { type: :string, format: :'date-time' }
               }

        let(:id) { create(:schedule).id }

        run_test!
      end

      response '404', 'schedule not found' do
        schema type: :object,
               properties: {
                 error: {
                   type: :object,
                   properties: {
                     code: { type: :integer },
                     message: { type: :string }
                   }
                 }
               }

        let(:id) { 'unknown' }

        run_test!
      end
    end

    patch 'Updates a schedule' do
      tags 'Schedules'
      consumes 'application/json'

      parameter name: :id, in: :path, type: :integer

      parameter name: :schedule, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          room_id: { type: :integer },
          start_time: { type: :string, format: :'date-time' },
          end_time: { type: :string, format: :'date-time' }
        },
        required: %w[title room_id start_time end_time]
      }

      let(:id) { create(:schedule).id }

      response '200', 'schedule updated' do
        let(:schedule) do
          { title: "Updated schedule #{Time.zone.now}" }
        end

        run_test!
      end

      response '422', 'invalid request' do
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

        run_test! do
          expect(Schedule.where(id:)).not_to exist
        end
      end

      response '404', 'schedule not found' do
        let(:id) { 'unknown' }

        run_test!
      end
    end
  end
end
