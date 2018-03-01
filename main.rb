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

vehicles_size = 2
rides_size = 3

scores = []
inputs.each do |input|
  Map.instance, rides = InputReader.parse_file("spec/fixtures/#{input}")
  vehicles = Map.instance.vehicles.times.map { Vehicle.new }

  loop do
    # m = vehicles_size.map do
    #   rides_size.map do
    #
    #   end
    # end
    current_vehicles = vehicles.sort_by { |v| v.t }.take(vehicles_size)
    break if current_vehicles.first.t > Map.instance.steps

    m = current_vehicles.map do |vehicle|
      vehicle_rides = rides.map do |ride|
        [ride, vehicle.rank(ride)]
      end

      vehicle_rides.sort_by { |ride, rank| rank }.reverse.take(rides_size)
    end

    m.each do |vv|
      puts "#{vv.inspect}"
    end
    puts ""

    i = 0
    max_i = m[0].length
    break if max_i.zero?
    while i < (max_i - 1)
      ride_a,  rank_a  = m[0][i]
      ride_a2, rank_a2 = m[0][i + 1]
      j = 1
      best_i = true
      while j < vehicles_size
        ride_b, rank_b = m[j][0]

        if (rank_b - rank_a) > (rank_a - rank_a2) # benefit > sacrifice
          best_i = false
          break
        end
        j = j + 1
      end
      break if best_i
      i = i + 1
    end
    current_vehicle = current_vehicles.first
    best_ride = m[0][i][0]

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
