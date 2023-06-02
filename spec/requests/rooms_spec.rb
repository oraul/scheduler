# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/rooms' do
  path '/rooms' do
    get 'Retrieves room list' do
      tags 'Rooms'
      produces 'application/json'

      request_body_example value: [{ id: 1, name: 'Room 1', created_at: Time.zone.now, updated_at: Time.zone.now }],
                           summary: 'Room example list'

      response '200', 'rooms found' do
        schema type: :array,
               items: {
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   created_at: { type: :string, format: :'date-time' },
                   updated_at: { type: :string, format: :'date-time' }
                 },
                 required: %w[id name created_at updated_at]
               }

        let!(:room) { create(:room) }

        run_test!
      end
    end

    post 'Creates a room' do
      tags 'Rooms'
      consumes 'application/json'
      parameter name: :room, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: %w[name]
      }

      response '201', 'room created' do
        let(:room) do
          { name: "Room #{Time.zone.now}" }
        end

        before do |example|
          expect { submit_request(example.metadata) }.to change(Room, :count).by(1)
        end

        it 'returns a 201 response' do |example|
          assert_response_matches_metadata(example.metadata)
        end
      end

      response '422', 'invalid request' do
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

      request_body_example value: { some_field: 'Foo' }, name: 'basic', summary: 'Request example description'

      response '200', 'room found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 title: { type: :string },
                 created_at: { type: :string, format: :'date-time' },
                 updated_at: { type: :string, format: :'date-time' }
               }

        let(:id) { create(:room).id }

        run_test!
      end

      response '404', 'room not found' do
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

    patch 'Updates a room' do
      tags 'Rooms'
      consumes 'application/json'

      parameter name: :id, in: :path, type: :integer

      parameter name: :room, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: %w[name]
      }

      let!(:id) { create(:room).id }

      response '200', 'room updated' do
        let(:room) do
          { name: "Updated Room #{Time.zone.now}" }
        end

        run_test!
      end

      response '422', 'invalid request' do
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
        let!(:id) { create(:room).id }

        before do |example|
          expect { submit_request(example.metadata) }.to change(Room, :count).by(-1)
        end

        it 'returns a 204 response' do |example|
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