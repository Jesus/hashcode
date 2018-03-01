class InputReader
  def self.parse_file(file)
    contents = File.read(file)
    heading, *rides = contents.split("\n")

    map = Map.new(*heading.split(" ").map(&:to_i))
    rides = rides.map do |ride|
      Ride.new(*ride.split(" ").map(&:to_i))
    end

    return [map, rides]
  end
end
