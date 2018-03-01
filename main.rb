#!/usr/bin/env ruby
require './lib/map'
require './lib/position'
require './lib/ride'
require './lib/vehicle'
require './lib/input_reader'

inputs = %w(
  a_example.in
  b_should_be_easy.in
  c_no_hurry.in
  d_metropolis.in
  e_high_bonus.in
).map { |f| "spec/fixtures/#{f}" }

Map.instance, rides = InputReader.parse_file(inputs[0])

vehicle_a = Vehicle.new
rides.each do |ride|
  puts "#{ride}: #{vehicle_a.rank(ride)}"
end

# puts Map.instance.inspect
# rides.each do |ride|
#   puts ride.inspect
# end
