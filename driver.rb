require_relative "location"

class Driver
  attr_accessor :name, :location, :books, :classes, :dinos
  def initialize(name, location)
    @name = name
    @location = location
    if !location.nil?
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
  end


  def move(prng)
    if !prng.is_a? Random
      raise "Not a valid pseudorandom number generator"
    end
    adj = @location.adj_locations
    if adj.nil?
      return nil
    end
    valid_locs, valid_roads = adj
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
