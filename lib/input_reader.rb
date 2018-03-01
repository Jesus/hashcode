class InputReader
  def self.parse_file(file)
    contents = File.read(file)
    heading, *rides = contents.split("\n")

    map = Map.new(*heading.split(" ").map(&:to_i))
    rides = rides.each_with_index.map do |ride, i|
      Ride.new(i, *ride.split(" ").map(&:to_i))
    end

    return [map, rides]
  end
end
