class Ride
  def initialize(a, b, x, y, s, f)
    @start = Position.new(a, b)
    @finish = Position.new(x, y)
    @t_start = s
    @t_finish = f
  end
end
