# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: 'http://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'localhost:3000'
            }
          }
        }
      ],
      components: {
        schemas: {
          Error: {
            type: 'object',
            properties: {
              message: { type: 'string' },
              detail: { type: 'object' }
            },
            required: %w[message]
          },
          Room: {
            type: 'object',
            properties: {
              id: { type: 'integer' },
              name: { type: 'string' },
              opened_at: { type: 'string', format: 'time' },
              closed_at: { type: 'string', format: 'time' },
              created_at: { type: 'string', format: 'date-time' },
              updated_at: { type: 'string', format: 'date-time' }
            },
            required: %w[id name opened_at closed_at created_at updated_at]
          },
          RoomCreate: {
            type: 'object',
            properties: {
              name: { type: 'string' },
              opened_at: { type: 'string', format: 'time' },
              closed_at: { type: 'string', format: 'time' }
            },
            required: %w[name opened_at closed_at]
          },
          Schedule: {
            type: 'object',
            properties: {
              id: { type: 'integer' },
              title: { type: 'string' },
              room_id: { type: 'integer' },
              started_at: { type: 'string', format: 'date-time' },
              ended_at: { type: 'string', format: 'date-time' },
              created_at: { type: 'string', format: 'date-time' },
              updated_at: { type: 'string', format: 'date-time' }
            },
            required: %w[id title started_at ended_at]
          },
          ScheduleCreate: {
            type: 'object',
            properties: {
              title: { type: 'string' },
              room_id: { type: 'integer' },
              started_at: { type: 'string', format: 'date-time' },
              ended_at: { type: 'string', format: 'date-time' }
            },
            required: %w[title room_id started_at ended_at]
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml

  # By default, if response body contains undocumented properties tests will pass.
  # To keep your responses clean and validate against a strict schema definition you can set the global config option:
  config.swagger_strict_schema_validation = true
end
