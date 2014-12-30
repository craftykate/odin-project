# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Airport.delete_all
Airport.create!([
								{name: "SFO"},
								{name: "ATL"},
								{name: "JFK"},
								{name: "ORD"}
								])

t = Time.now
hours = 60
days = 60*60*24
def randomize
	Random.new.rand(11.1..15.9)
end
Flight.delete_all
20.times do 
	Flight.create!([
								 	{start_location: Airport.find_by(name: "SFO"), 
								 	 end_location: Airport.find_by(name: "ATL"), 
								 	 start_time: t + randomize*days,
								 	 duration: 6*hours
								 	},
								 	{start_location: Airport.find_by(name: "SFO"), 
								 	 end_location: Airport.find_by(name: "JFK"), 
								 	 start_time: t + randomize*days,
								 	 duration: 6*hours
								 	},
								 	{start_location: Airport.find_by(name: "SFO"), 
								 	 end_location: Airport.find_by(name: "ORD"), 
								 	 start_time: t + randomize*days,
								 	 duration: 5*hours
								 	}
								])
end
20.times do 
	Flight.create!([
								 	{start_location: Airport.find_by(name: "ATL"), 
								 	 end_location: Airport.find_by(name: "SFO"), 
								 	 start_time: t + randomize*days,
								 	 duration: 6*hours
								 	},
								 	{start_location: Airport.find_by(name: "ATL"), 
								 	 end_location: Airport.find_by(name: "JFK"), 
								 	 start_time: t + randomize*days,
								 	 duration: 3*hours
								 	},
								 	{start_location: Airport.find_by(name: "ATL"), 
								 	 end_location: Airport.find_by(name: "ORD"), 
								 	 start_time: t + randomize*days,
								 	 duration: 3*hours
								 	}
								])
end
20.times do 
	Flight.create!([
								 	{start_location: Airport.find_by(name: "JFK"), 
								 	 end_location: Airport.find_by(name: "ATL"), 
								 	 start_time: t + randomize*days,
								 	 duration: 3*hours
								 	},
								 	{start_location: Airport.find_by(name: "JFK"), 
								 	 end_location: Airport.find_by(name: "SFO"), 
								 	 start_time: t + randomize*days,
								 	 duration: 6*hours
								 	},
								 	{start_location: Airport.find_by(name: "JFK"), 
								 	 end_location: Airport.find_by(name: "ORD"), 
								 	 start_time: t + randomize*days,
								 	 duration: 2*hours
								 	}
								])
end
20.times do 
	Flight.create!([
								 	{start_location: Airport.find_by(name: "ORD"), 
								 	 end_location: Airport.find_by(name: "ATL"), 
								 	 start_time: t + randomize*days,
								 	 duration: 3*hours
								 	},
								 	{start_location: Airport.find_by(name: "ORD"), 
								 	 end_location: Airport.find_by(name: "JFK"), 
								 	 start_time: t + randomize*days,
								 	 duration: 2*hours
								 	},
								 	{start_location: Airport.find_by(name: "ORD"), 
								 	 end_location: Airport.find_by(name: "SFO"), 
								 	 start_time: t + randomize*days,
								 	 duration: 5*hours
								 	}
								 ])
end