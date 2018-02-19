require_relative "road"
class Location
  attr_accessor :name, :roads, :classes, :books, :dinos

  def initialize (name, roads = nil, classes, books, dinos)
    @name = name
    @roads = roads
    @classes = classes
    @books = books
    @dinos = dinos
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
    ret_locs = Array::new
    ret_roads = Array::new
    roads.each{|road|  road.adj_locations(self).each{|x| ret_locs << x; ret_roads << road}}
    return ret_locs, ret_roads
  end
end
