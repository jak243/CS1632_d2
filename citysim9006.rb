require_relative "road"
require_relative "location"
require_relative "driver"

if ARGV.size != 1
  abort "You must provide a single integer as a seed. Exiting..."
end

prng = Random::new ARGV[0].to_i
all_city_locs = Array::new

hospital = Location::new "Hospital", nil, false, false, false
cathedral = Location::new "Cathedral", nil, true, false, false
museum = Location::new "Museum", nil, false, false, true
hillman = Location::new "Hillman", nil, false, true, false
monroeville = Location::new "Monroeville", nil, false, false, false
downtown = Location::new "Downtown", nil, false, false, false

fourth = Road::new "Fourth Ave.", true, [hospital,cathedral,monroeville]
fifth = Road::new "Fourth Ave.", true, [museum,hillman,downtown]
foo = Road::new "Foo St.", false, [hospital,hillman]
bar = Road::new "Bar St.", false, [cathedral,museum]

hospital.roads = [fourth, foo]
cathedral.roads = [fourth, bar]
monroeville.roads = [fourth]
museum.roads = [fifth, bar]
hillman.roads = [fifth, foo]
downtown.roads = [fifth]
all_city_locs = [hospital,cathedral,museum,hillman]

drivers = Array::new

for i in 1..5 do
  newdriver = Driver::new "Driver #{i}", all_city_locs[prng.rand(4)]
  drivers << newdriver
end

drivers.each do |driver|
  until driver.location == downtown || driver.location == monroeville
    curr_location = driver.location
    next_location, via_road = driver.move(prng)
    puts driver.name+" heading from "+curr_location.name+" to "+next_location.name+" via "+via_road.get_name
  end
  if driver.books ==1
    puts driver.name+" obtained #{driver.books} book!"
  else
    puts driver.name+" obtained #{driver.books} books!"
  end
  if driver.dinos ==1
    puts driver.name+" obtained #{driver.dinos} dinosaur toy!"
  else
    puts driver.name+" obtained #{driver.dinos} dinosaur toys!"
  end
  if driver.classes ==1
    puts driver.name+" attended #{driver.classes} class!"
  else
    puts driver.name+" attended #{driver.classes} classes!"
  end
end
