class Stage

  def initialize(vehicles,rides)
    @vehicles=vehicles
    @rides=rides
    @ranks={} # rank[ride][vehicle] = rank
    v0 = vehicles.first
    rides.each do |ri|
      rnk = v0.rank(ri)
      ranks_ri ={}
      vehicles.each do |vi|
        ranks_ri[vi] = rnk
      end
      @ranks[ri]=ranks_ri 
    end
  end
  
  def apply(vi, ri)
    vi.take(ri)
    @rides.delete ri
    @ranks.delete ri
    refresh_vehicle(vi)
  end
  
  def apply_best
    return false if @rides.length == 0
    rmax = @rides.first
    vmax = @vehicles.first
    rnkmax = 0.0
    @ranks.each do |ri, vhash|
      vhash.each do |vi, rnk|
        if rnk> rnkmax
          rmax=ri
          vmax=vi
          rnkmax = rnk
        end
      end
    end
    return false if rnkmax==0
    apply(vmax,rmax)
    return true
  end
  
#  def refresh_ride(ri)
#    vhash = {}
#    @vehicles.each { |vi| vhash[vi] = vi.rank(ri) }
#    @ranks[ri] = hash
#  end
  
  def refresh_vehicle(vi)
    @ranks.each { |ri, vhash| vhash[vi] = vi.rank(ri) }
  end
end