#!/usr/bin/env ruby
require 'lib/map'
require 'lib/position'
require 'lib/ride'
require 'lib/vehicle'
require 'lib/Stage'
require 'lib/input_reader'
require 'util'

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

path_nyapa = "/home/fjburgos/programs/hashcode/"

scores = []
inputs.each do |input|
  Map.instance, rides = InputReader.parse_file(path_nyapa + "spec/fixtures/#{input}")
  vehicles = (1..Map.instance.vehicles).map { |i| Vehicle.new(i) }
  stg = Stage.new(vehicles,rides)

  while stg.apply_best
  end

  output_file = path_nyapa + "output/#{input.gsub('.in', '.o')}"
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
