require_relative "location"

class Driver
  attr_accessor :name, :location, :books, :classes, :dinos
  def initialize(name, location, books, classes, dinos)
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
    valid_locs = @location.adj_locations
    @location = valid_locs[prng.rand(valid_locs.size)]
    if @location.class?
      @classes = @classes*2
    end
    if @location.books?
      @books += 1
    end
    if @location.dinos?
      @dinos += 1
    end
    return @location
  end


end
