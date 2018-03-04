class Vehicle
  attr_reader :t,
              :rides,
              :score,
              :pos,
              :id

  def initialize(id)
    @pos = Position.new(0, 0)
    @t = 0
    @score = 0.0
    @rides = []
    @id=id
  end

  def take(ride)
    distance_to_ride  = @pos.distance_to(ride.start)
    arrival_time      = @t + distance_to_ride
    has_bonus         = arrival_time <= ride.t_start
    start_time        = has_bonus ? ride.t_start : arrival_time

    @t = start_time + ride.distance
    @rides << ride
    @pos = ride.finish
    @score += ride.distance + (has_bonus ? Map.instance.bonus : 0)
  end

  def rank(ride)
    distance_to_ride  = @pos.distance_to(ride.start)
    arrival_time      = @t + distance_to_ride
    has_bonus         = arrival_time <= ride.t_start
    start_time        = has_bonus ? ride.t_start : arrival_time
    finish_time       = start_time + ride.distance

    return 0 if finish_time > Map.instance.steps
    return 0 if finish_time > ride.t_finish

    (ride.distance + (has_bonus ? Map.instance.bonus : 0.0)) / (start_time + ride.distance - @t).to_f
  end
  
  def inspect
    "V#{id}"
  end

end
