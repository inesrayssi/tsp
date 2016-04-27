require "pry"
require "./city.rb"
require "./tour.rb"

srand(0)

cities8, cities10, cities100, cities1000 =
  [8, 10, 100, 1000].map { |n|
    City.random_cities(n)
  }

def all_tours(cities)
  start = cities.first
  (cities - [start]).permutation.map { |permutation|
    Tour.new([start] + permutation)
  }
end

def exact_tsp(cities)
  shortest(all_tours(cities))
end

def shortest(tours)
  tours.min_by(&:distance)
end

def greedy_tsp(cities)
  start = cities.first
  tour = [start]
  unvisited = cities - [start]
  loop do
    break unless unvisited.any?
    c = nearest_neighbor(tour[-1], unvisited)
    tour.push(c)
    unvisited.delete(c)
  end

  Tour.new(tour)
end

def nearest_neighbor(a, cities)
  cities.min_by { |city|
    City.distance(a, city)
  }
end

=begin
exact = exact_tsp(cities10)
puts exact.distance
exact.plot("exact")
=end

greedy = greedy_tsp(cities1000)
puts greedy.distance
greedy.plot("greedy")

