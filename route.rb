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
    valid!
  end

  def valid?
    valid!
  rescue StandardError
    false
  end

  def add_station(station)
    return if list.include? station

    list.insert(-2, station)
  end

  def del_station(station)
    list.delete(station) if list.include? station
  end

  protected

  def valid!
    raise "Stations and title can't be nil!" if first_station.nil? || last_station.nil? || title.nil?
    raise 'Title must have at least 1 symbol!' if title.length.zero?
  end
end
