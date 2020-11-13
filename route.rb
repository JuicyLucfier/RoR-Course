# frozen_string_literal: true

# Route
class Route
  include InstanceCounter
  attr_accessor :title, :first_station, :last_station, :list

  def initialize(first_station, last_station, title)
    @first_station = first_station
    @last_station = last_station
    @list = [first_station, last_station]
    @title = title
    register_instances
  end

  def add_station(station)
    return if list.include? station

    list.insert(-2, station)
  end

  def del_station(station)
    list.delete(station) if list.include? station
  end
end
