class Position
  attr_accessor :r, :c
  def initialize(r, c)
    @r = r
    @c = c
  end
  
  def distance_to(pos)
    return (pos.r-@r).abs + (pos.c-@c).abs 
  end
end
