class Map
  class << self
    attr_accessor :instance
  end

  attr_reader :rows,
              :columns,
              :vehicles,
              :rides,
              :bonus,
              :steps

  def initialize(rows, columns, vehicles, rides, bonus, steps)
    @rows = rows
    @columns = columns
    @vehicles = vehicles
    @rides = rides
    @bonus = bonus
    @steps = steps
  end
end
