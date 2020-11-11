# frozen_string_literal: true

# Passenger train
class PassengerTrain < Train
  attr_accessor :type

  def initialize(number, type = 'Пассажирский')
    super
  end
end
