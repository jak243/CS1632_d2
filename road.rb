require_relative "location"

class Road
  attr_accessor :name, :oneway, :locations
  def initialize (name = nil, oneway = nil, locations = nil)
    @name = name
    @oneway = oneway
    @locations = locations
  end

  def adj_locations(current)
    if !current.is_a? Location
      return nil
    end
    if @locations.size <= 1
      return nil
    end
    index = @locations.index(current)
    if  @oneway && index == @locations.size-1
      return nil
    end
    if !@oneway && !@locations[index-1].nil? && !@locations[index+1].nil? && index != 0
      return Array::new [@locations[index+1], @locations[index-1]]
    elsif @oneway || index == 0
      return Array::new [@locations[index+1]]
    else
      return Array::new [@locations[index-1]]
    end
  end

end
