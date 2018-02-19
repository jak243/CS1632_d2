require_relative "location"

class Driver
  attr_accessor :name, :location, :books, :classes, :dinos
  def initialize(name, location)
    @name = name
    @location = location
    if location.class?
      @classes = 2
    else
      @classes = 1
    end
    if location.books?
      @books = 1
    else
      @books = 0
    end
    if location.dinos?
      @dinos = 1
    else
      @dinos = 0
    end
  end


  def move(prng)
    valid_locs, valid_roads = @location.adj_locations
    randIndex = prng.rand(valid_locs.size)
    @location = valid_locs[randIndex]
    if @location.class?
      @classes = @classes*2
    end
    if @location.books?
      @books += 1
    end
    if @location.dinos?
      @dinos += 1
    end
    return @location, valid_roads[randIndex]
  end
end
