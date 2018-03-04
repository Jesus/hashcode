require 'set'
require 'lib/Rank'
require 'lib/red_black_tree'

class RankSet
  def initialize
    @ranks=RedBlackTree.new
  end
  
  def best
    e0 = @ranks.first_key
  end
  
  def apply(rides,rank)
    #@ranks.dump_tree(STDOUT)
    rank.vehicle.take(rank.ride)
    delete(rank.vehicle,rank.ride)
    rides.each { |ride| add Rank.new(rank.vehicle,ride)}
  end
  
  def delete(vehicle,ride)
    to_delete = @ranks.select {|k,v| k.ride == ride || k.vehicle == vehicle}.map{|k,v| k}
    to_delete.each {|k| @ranks.delete(k)}
  end
  
  def add(rank)
    @ranks[rank]=0
  end
end