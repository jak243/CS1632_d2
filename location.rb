require_relative "road"
class Location
  attr_accessor :name, :roads, :classes, :books, :dinos

  def initialize (name = nil, roads = nil, classes = false, books = false, dinos = false)
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
    if @roads.nil?
      return nil
    end

    if @roads.empty?
      return nil
    end
    ret_locs = Array::new
    ret_roads = Array::new

    roads.each do |road|
      if !road.adj_locations(self).nil?
        road.adj_locations(self).each{|x| ret_locs << x; ret_roads << road}
      end
    end
    if ret_locs.empty?
      return nil
    end 
    return ret_locs, ret_roads
  end
end
