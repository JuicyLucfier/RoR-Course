# frozen_string_literal: true

# Station
class Station
  attr_accessor :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def get_train(train)
    trains.push(train)
  end

  def trains_by_type(type)
    filter = trains.select { |trains| trains.type == type }
    filter.length
    filter
  end

  def send_train(train)
    trains.delete(train)
  end
end

# Route
class Route
  attr_accessor :first_station, :last_station, :list

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @list = [first_station, last_station]
  end

  def add_station(station)
    return if list.include? station

    list.insert(-2, station)
  end

  def del_station(station)
    list.delete(station) if list.include? station
  end
end
# Train
class Train
  attr_accessor :speed, :wagons, :route, :current_station, :number, :type

  def initialize(number, type, wagons)
    @speed = 0
    @number = number
    @type = type
    @wagons = wagons
  end

  def accelerate(value)
    self.speed += value
  end

  def stop
    self.speed = 0
  end

  def add_wagon
    self.wagons += 1 if self.speed.zero?
  end

  def del_wagon
    return unless self.speed.zero? && self.wagons.positive?

    self.wagons -= 1
  end

  def new_route(route)
    self.route = route
    self.current_station = route.list[0]
    current_station.get_train(self)
  end

  def go
    return unless next_station

    current_station.send_train(self)
    self.current_station = next_station
    current_station.get_train(self)
  end

  def back
    return unless last_station

    current_station.send_train(self)
    self.current_station = last_station
    current_station.get_train(self)
  end

  def last_station
    route.list[route.list.index(current_station) - 1] if route.list.index(current_station) != 0
  end

  def next_station
    route.list[route.list.index(current_station) + 1] if route.list.index(current_station) != route.list.length - 1
  end
end
