# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/rooms' do
  path '/rooms' do
    get 'Retrieves room list' do
      tags 'Rooms'
      produces 'application/json'

      response '200', 'rooms found' do
        schema type: :array,
               items: { '$ref' => '#/components/schemas/Room' }

        let(:room) { create(:room) }

        run_test!
      end
    end

    post 'Creates a room' do
      tags 'Rooms'
      consumes 'application/json'
      parameter name: :room, in: :body, schema: { '$ref' => '#/components/schemas/RoomCreate' }

      response '201', 'room created' do
        let(:room) do
          { name: "Room #{Time.zone.now}", start_time: '08:00:00', end_time: '09:00:00' }
        end

        it 'returns a 201 response' do |example|
          expect { submit_request(example.metadata) }.to change(Room, :count).by(1)

          assert_response_matches_metadata(example.metadata)
        end
      end

      response '422', 'invalid request' do
        schema '$ref' => '#/components/schemas/Error'

        let(:room) do
          { name: nil }
        end

        run_test!
      end
    end
  end

  path '/rooms/{id}' do
    get 'Retrieves a room' do
      tags 'Rooms'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'room found' do
        schema '$ref' => '#/components/schemas/Room'

        let(:id) { create(:room).id }

        run_test!
      end

      response '404', 'room not found' do
        schema '$ref' => '#/components/schemas/Error'

        let(:id) { 'unknown' }

        run_test!
      end
    end

    patch 'Updates a room' do
      tags 'Rooms'
      consumes 'application/json'

      parameter name: :id, in: :path, type: :integer

      parameter name: :room, in: :body, schema: { '$ref' => '#/components/schemas/RoomCreate' }

      let(:id) { create(:room).id }

      response '200', 'room updated' do
        let(:room) do
          { name: "Updated Room #{Time.zone.now}" }
        end

        run_test!
      end

      response '422', 'invalid request' do
        schema '$ref' => '#/components/schemas/Error'

        let(:room) do
          { name: nil }
        end

        run_test!
      end
    end

    delete 'Deletes a room' do
      tags 'Rooms'
      consumes 'application/json'

      parameter name: :id, in: :path, type: :integer

      response '204', 'room deleted' do
        let(:id) { create(:room).id }

        it 'returns a 204 response' do |example|
          expect { submit_request(example.metadata) }.to change { Room.where(id:).count }.by(-1)

          assert_response_matches_metadata(example.metadata)
        end
      end

      response '404', 'room not found' do
        let(:id) { 'unknown' }

        run_test!
      end
    end
  end
end
