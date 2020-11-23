# frozen_string_literal: true

# Passenger train
class PassengerTrain < Train
  attr_accessor :type

  def initialize(name, type = 'Пассажирский')
    super
  end
end
