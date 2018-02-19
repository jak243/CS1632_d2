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
  # current = one way road location with valid adjacent locations in the forward directions -> returns array of valid adjacent locations in only the forward direction
  # current = one way road location with valid adjacent locations in the backward direction -> returns nil


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
end
