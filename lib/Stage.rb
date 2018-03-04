require 'lib/RankSet'
require 'lib/Rank'

class Stage

  def initialize(vehicles,rides)
    @vehicles=vehicles
    @rides=rides
    @ranks=RankSet.new
    rides.each do |ri|
      vehicles.each do |vi|
        @ranks.add  Rank.new(vi,ri) 
      end
    end
  end
  
  def apply(best_rank)
    @rides.delete best_rank.ride
    @ranks.apply(@rides, best_rank)
  end
  
  def apply_best
    return false if @rides.length == 0
    best = @ranks.best
    return false if best.rank==0
    apply(best)
    return true
  end
  
end