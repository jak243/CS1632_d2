require_relative "road"
class Location
  attr_accessor :name, :roads, :classes, :books, :dinos

  def initialize (name, roads, classes, books, dinos)
    @name = name
    @roads = roads
    @classes = classes
    @books = books
    @dinos = dinos
  end

  def get_name
    return @name
  end

  def get_roads
    return @roads
  end

  def class?
    return @classes
  end

  def books?
    return @books
  end

  def dinos?
    return @dinos
  end

  def adj_locations
    ret = Array.new
    roads.each{|road|  ret << :(road.adj_locations)}
    return ret
  end

end
