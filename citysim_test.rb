require_relative 'road'
require_relative 'location'
require_relative 'driver'
require 'minitest/autorun'


class RoadTest < Minitest::Test
  def setup
    @r = Road::new nil,nil,nil
  end

  def test_new_road_not_nil
    refute_nil @r
    assert_kind_of Road, @r
  end

  # UNIT TESTS FOR METHOD adj_locations(current)
  # equivalence classes:
  # current = (not a location) -> returns nil
  # current = location with no valid adjacent locations -> returns nil
  # current = two way road location with valid adjacent locations in both directions -> returns array of valid adjacent locations in both directions
  # current = two way road location with valid adjacent locations in negative direction -> returns array of valid adjacent location in negative directions
  # current = two way road location with valid adjacent locations in positive direction -> returns array of valid adjacent location in positive directions
  # current = one way road location with valid adjacent locations in both directions -> returns array of valid adjacent locations in only the forward direction
  # current = one way road location with valid adjacent locations in the positive directions -> returns array of valid adjacent location in only the pos direction
  # current = one way road location with valid adjacent locations in the negative direction -> returns nil


  #If an invalid object, such as a string, is given for current
  #then nil is returned
  #EDGE CASE
  def test_road_adj_locations_not_a_location
    assert_nil @r.adj_locations "foo"
  end

  #If current location has no adjacent locations on this road nil is returned
  #EDGE CASE
  def test_road_adj_location_with_no_adj_locations
    location1 = Location::new
    @r.locations = Array::new [location1]
    @r.oneway = false
    assert_nil @r.adj_locations(location1)
  end

  #If a two way road location with valid locations in both directions will return array of both valid locations
  def test_road_adj_location_with_adj_locations_2way
    location1 = Location::new
    location2 = Location::new
    location3 = Location::new
    location4 = Location::new
    @r.oneway = false
    @r.locations = Array::new [location1,location2,location3,location4]
    assert_equal [location3,location1], @r.adj_locations(location2)
  end
  #If a two way road location with valid locations in negative direction will return array of one valid location in negative direction
  def test_road_adj_location_with_adj_location_2way_pos
    location1 = Location::new
    location2 = Location::new
    location3 = Location::new
    location4 = Location::new
    @r.oneway = false
    @r.locations = Array::new [location1,location2,location3,location4]
    assert_equal [location3], @r.adj_locations(location4)
  end
  #If a two way road location with valid locations in positive direction will return array of one valid location in positive direction
  def test_road_adj_location_with_adj_location_2way_neg
    location1 = Location::new
    location2 = Location::new
    location3 = Location::new
    location4 = Location::new
    @r.oneway = false
    @r.locations = Array::new [location1,location2,location3,location4]
    assert_equal [location2], @r.adj_locations(location1)
  end
  #If a one way road location with valid locations in both directions will return array of one valid location in the pos direction
  def test_road_adj_location_with_adj_locations_1way
    location1 = Location::new
    location2 = Location::new
    location3 = Location::new
    location4 = Location::new
    @r.oneway = true
    @r.locations = Array::new [location1,location2,location3,location4]
    assert_equal [location3], @r.adj_locations(location2)
  end
  #If a two way road location with valid locations in positive direction only will return array of one valid location in positice direction
  def test_road_adj_location_with_adj_location_1way_pos
    location1 = Location::new
    location2 = Location::new
    location3 = Location::new
    location4 = Location::new
    @r.oneway = true
    @r.locations = Array::new [location1,location2,location3,location4]
    assert_equal [location2], @r.adj_locations(location1)
  end
  #If a two way road location with valid locations in positive direction will return nil
  def test_road_adj_location_with_adj_location_1way_neg
    location1 = Location::new
    location2 = Location::new
    location3 = Location::new
    location4 = Location::new
    @r.oneway = true
    @r.locations = Array::new [location1,location2,location3,location4]
    assert_nil @r.adj_locations(location4)
  end
end

class LocationTest < Minitest::Test
  def setup
    @l = Location::new
  end

  def test_new_location_not_nil
    refute_nil @l
    assert_kind_of Location, @l
  end

  # UNIT TESTS FOR METHOD adj_locations Location
  # equivalence classes:
  # @roads is nil -> returns nil
  # @roads is empty -> returns nil
  # no adjacent locations along any of the roads in @roads -> return nil
  # adjacent locations on roads in roads -> returns two arrays one with adjacent
  # locations and the other with the roads connecting the locations

  #if @roads is nil then returns nil
  #EDGE CASE
  def test_location_adj_locations_nil
    assert_nil @l.adj_locations
  end

  #if @roads is empty then returns nil
  #EDGE CASE
  def test_location_adj_locations_empty
    assert_nil @l.adj_locations
  end

  #if  no adjacent locations along any of the roads in @roads -> return nil
  def test_location_adj_locations_no_adj_locs
    r1 = Minitest::Mock.new("mock road1")
    r2 = Minitest::Mock.new("mock road2")
    def r1.adj_locations(current)
      return nil
    end
    def r2.adj_locations(current)
      return nil
    end
    @l.roads = [r1,r2]
    assert_nil @l.adj_locations
  end

  # adjacent locations on roads in roads -> returns two arrays one with adjacent
  # locations and the other with the roads connecting the locations
  def test_location_adj_locations_adj_locs
    r1 = Minitest::Mock.new("mock road1")
    r2 = Minitest::Mock.new("mock road2")

    def r1.adj_locations(current)
      return ["location 1"]
    end
    def r2.adj_locations(current)
      return ["location 2"]
    end
    @l.roads = [r1,r2]
    assert_equal [["location 1","location 2"],[r1,r2]],@l.adj_locations
  end
end

class DriverTest < Minitest::Test
  def setup
    @d = Driver::new nil,nil
  end

  def test_new_driver_not_nil
    refute_nil @d
    assert_kind_of Driver, @d
  end

  #UNIT TESTS for initialization
  #equivalence classes
  #if the location the driver starts at offers classes -> classes is intialized to 2
  #if the location the driver starts at offers books -> books is intialized to 1
  #if the location the driver starts at offers dinosaur toys -> dinos is intialized to 1

  #if the location the driver starts at offers only classes -> classes is intialized to 2, books and dinos to 0
  def test_intialize_offers_classes
    l1 = Minitest::Mock.new("mock location1")
    def l1.class?; true; end
    def l1.books?; false; end
    def l1.dinos?; false; end
    d1 = Driver::new nil,l1
    assert_equal 2,d1.classes
    assert_equal 0,d1.books
    assert_equal 0,d1.dinos
  end

  #if the location the driver starts at offers only books -> books is intialized to 1 classes to 1 and dinos to 0
  def test_intialize_offers_classes
    l1 = Minitest::Mock.new("mock location1")
    def l1.class?; false; end
    def l1.books?; true; end
    def l1.dinos?; false; end
    d1 = Driver::new nil,l1
    assert_equal 1,d1.classes
    assert_equal 1,d1.books
    assert_equal 0,d1.dinos
  end

  #if the location the driver starts at offers only dinosaur toys -> dinos is intialized to 1, classes to 1, and books to 0
  def test_intialize_offers_classes
    l1 = Minitest::Mock.new("mock location1")
    def l1.class?; false; end
    def l1.books?; false; end
    def l1.dinos?; true; end
    d1 = Driver::new nil,l1
    assert_equal 1,d1.classes
    assert_equal 0,d1.books
    assert_equal 1,d1.dinos
  end

  #UNIT TESTS FOR move(prng)
  #prng is not a valid pseudorandom number generator -> raises "Prng must be a pseudorandom numbger generator instance"
  # @location.adj_locations returns nil -> returns nil
  # if there are valid adjacent roads -> @location is set to a pseudorandom one and the method returns @location and the road at the same index
  # if the driver moves to a location that offers classes -> the number of classes the driver has taken doubles
  # if the driver moves to a location that offers books -> the number of books the driver has obtained increases by one
  # if the driver moves to a location that offers dinos -> the number of dinos the driver has obtained increases by one

  #prng is not a valid pseudorandom number generator -> raises "Not a valid pseudorandom number generator"
  def test_move_invalid_prng
    assert_raises "Not a valid pseudorandom number generator" do
      d1 = Driver::new nil,nil
      d1.move("silly-snake")
    end
  end

  # if there are valid adjacent roads -> @location is set to a pseudorandom one and the method returns @location and the road at the same index
  def test_move_nil_adj_locations
    assert_raises "Not a valid pseudorandom number generator" do
      d1 = Driver::new nil,nil
      d1.move("silly-snake")
    end
  end

end
