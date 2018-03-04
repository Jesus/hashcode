#!/usr/bin/env ruby
require './lib/map'
require './lib/position'
require './lib/ride'
require './lib/vehicle'
require './lib/input_reader'
require './util'

inputs = %w(
  a_example.in
  b_should_be_easy.in
  c_no_hurry.in
  d_metropolis.in
  e_high_bonus.in
)
inputs = %w(
  a_example.in
  b_should_be_easy.in
)

scores = []
inputs.each do |input|
  Map.instance, rides = InputReader.parse_file("spec/fixtures/#{input}")
  vehicles = Map.instance.vehicles.times.map { Vehicle.new }

  loop do
    current_vehicle = vehicles.min_by { |v| v.t }
    break if current_vehicle.t > Map.instance.steps
    best_ride = rides.max_by { |ride| current_vehicle.rank(ride) }
    break if best_ride.nil?

    current_vehicle.take(best_ride)
    rides.delete best_ride
  end

  output_file = "output/#{input.gsub('.in', '.o')}"
  File.open(output_file, 'w') do |file|
    vehicles.each do |vehicle|
      vehicle_rides = vehicle.rides.map { |r| r.id }
      file.write("#{vehicle_rides.length} #{vehicle_rides.join(' ')}\n")
    end
  end
  input_score = vehicles.map(&:score).sum
  scores << input_score
  puts "#{input}: #{input_score}"
end
puts "Total score: #{scores.sum}"
