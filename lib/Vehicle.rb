class Vehicle
  attr_reader :t,
              :rides

  def initialize
    @pos = Position.new(0, 0)
    @t = 0
    @rides = []
  end

  def take(ride)
    distance_to_ride  = @pos.distance_to(ride.start)
    arrival_time      = @t + distance_to_ride
    has_bonus         = arrival_time <= ride.t_start
    start_time        = has_bonus ? ride.t_start : arrival_time

    @t = start_time + ride.distance
    @rides << ride
  end

  def rank(ride)
    distance_to_ride  = @pos.distance_to(ride.start)
    arrival_time      = @t + distance_to_ride
    has_bonus         = arrival_time <= ride.t_start
    start_time        = has_bonus ? ride.t_start : arrival_time

    if start_time + ride.distance > ride.t_finish
      0
    else
      (ride.distance + (has_bonus ? Map.instance.bonus : 0)) / (start_time + ride.distance - @t).to_f
    end
  end
end
