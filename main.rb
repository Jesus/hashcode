#!/usr/bin/env ruby
require './lib/map'
require './lib/position'
require './lib/ride'
require './lib/input_reader'

inputs = %w(
  a_example.in
  b_should_be_easy.in
  c_no_hurry.in
  d_metropolis.in
  e_high_bonus.in
).map { |f| "spec/fixtures/#{f}" }

map, rides = InputReader.parse_file(inputs[0])

puts map.inspect
rides.each do |ride|
  puts ride.inspect
end
