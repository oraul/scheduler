#!/bin/bash
set -e

# Run specs
bundle exec rspec spec/

# Generate swagger files
bin/rails rswag
