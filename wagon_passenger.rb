# frozen_string_literal: true

# Passenger Wagon
class WagonPassenger < Wagon
  attr_accessor :type

  def initialize
    @type = 'Пассажирский'
    super
  end
end
