# frozen_string_literal: true

# Passenger train
class PassengerTrain < Train
  attr_accessor :type, :number

  def initialize(number, type = 'Пассажирский')
    @type = type
    @number = number
    super
  end
end
