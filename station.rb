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

  def send_train(train)
    trains.delete(train)
  end

  def trains_by_type(type)
    filter = trains.select { |trains| trains.type == type }
    filter.length
    filter
  end
end
