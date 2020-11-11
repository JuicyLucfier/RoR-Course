# frozen_string_literal: true

# Train
class Train
  attr_accessor :speed, :wagons, :route, :current_station, :number, :type

  def initialize(number, type)
    @speed = 0
    @number = number
    @type = type
    @wagons = []
  end

  def accelerate(value)
    self.speed += value
  end

  def stop
    self.speed = 0
  end

  def add_wagon(wagon)
    wagons.push(wagon) if self.speed.zero? && wagon.type == type
  end

  def delete_wagon
    return unless self.speed.zero? && wagons.length.positive?

    wagons.pop
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
