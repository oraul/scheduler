# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Room.insert_all(
  [
    { name: 'Room 1', start_time: '08:00:00', end_time: '09:00:00' },
    { name: 'Room 2', start_time: '08:00:00', end_time: '09:00:00' },
    { name: 'Room 3', start_time: '08:00:00', end_time: '09:00:00' },
    { name: 'Room 4', start_time: '08:00:00', end_time: '09:00:00' }
  ]
)
