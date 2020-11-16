# frozen_string_literal: true

# Train
class Train
  include Company
  include InstanceCounter
  attr_accessor :speed, :wagons, :route, :current_station, :number, :type

  NUMBER_FORMAT = /^[a-z0-9а-я]{3}-?[a-z0-9а-я]{2}$/i.freeze

  @@trains = []
  def initialize(number, type)
    register_instances
    @speed = 0
    @number = number
    @type = type
    @wagons = []
    @@trains << self
    valid!
  end

  def valid?
    valid!
  rescue StandardError
    false
  end

  def wagons_block
    yield(wagons) if block_given?
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

  def self.find(train_number)
    found = @@trains.select { |train| train.number == train_number }
    return found[0] unless found.empty?
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

  protected

  def valid!
    raise "Number can't be nil!" if number.nil?
    raise "Type can't be nil!" if type.nil?
    raise 'Number and type must have at least 1 symbol!' if number.length.zero? || type.length.zero?
    raise 'Number has invalid format!' if number !~ NUMBER_FORMAT
  end
end
