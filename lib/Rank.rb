class Rank
  attr_reader :vehicle,
              :ride,
              :score,
              :rank,
              :time_to_start              
              
  def initialize(vehicle,ride)
    @vehicle=vehicle
    @ride=ride
    distance_to_ride  = vehicle.pos.distance_to(ride.start)
    arrival_time      = vehicle.t + distance_to_ride
    has_bonus         = arrival_time <= ride.t_start
    @time_to_start    = has_bonus ? (ride.t_start - vehicle.t) : distance_to_ride
    start_time        = has_bonus ? ride.t_start : arrival_time
    finish_time       = start_time + ride.distance

    if finish_time > Map.instance.steps || finish_time > ride.t_finish
      @score = 0
      @rank = 0.0
    else
      @score = ride.distance + (has_bonus ? Map.instance.bonus : 0)
      @rank = @score / (finish_time - vehicle.t).to_f
    end
 end
 
  def <=> other
    return -(@rank<=>other.rank)          if @rank != other.rank
    return @ride.id<=>other.ride.id       if @ride.id != other.ride.id
    return @vehicle.id<=>other.vehicle.id #if @vehicle.id != other.vehicle.id
  end
# def <=> other
#   return @rank != other.rank ? 
#                -(@rank<=>other.rank) :
#                @time_to_start<=>other.time_to_start
# end
end