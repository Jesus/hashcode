class Ride
  attr_reader :start,
              :finish,
              :t_start,
              :t_finish,
              :id

  def initialize(id, a, b, x, y, s, f)
    @id = id
    @start = Position.new(a, b)
    @finish = Position.new(x, y)
    @t_start = s
    @t_finish = f
  end

  def distance
    @start.distance_to @finish
  end
end
