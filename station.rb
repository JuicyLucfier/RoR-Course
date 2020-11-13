# frozen_string_literal: true

# Station
class Station
  include InstanceCounter
  attr_accessor :name, :trains

  @@stations = []
  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instances
  end

  def get_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end

  def trains_by_type(type)
    trains.select { |trains| trains.type == type }
  end

  def self.all
    @@stations
  end
end
