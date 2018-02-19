require_relative "location"

class Road
  attr_accessor :name, :oneway, :locations


  def initialize (name, oneway, locations)
    @name = name
    @oneway = oneway
    @locations = locations
  end

  def adj_locations(current)
    index = @locations.index(current)
    if @oneway
      return @locations[index+1]
    else
      return @locations[index+1], @locations[index-1]
  end

  def add_location(newloc)
    @locations << :newloc
  end

  def get_name
    return @name
  end
end
