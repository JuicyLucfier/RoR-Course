# frozen_string_literal: true

# Passenger Wagon
class WagonPassenger < Wagon
  attr_accessor :type, :seats, :seats_taken

  def initialize(seats, type = 'Пассажирский')
    @seats = seats
    @seats_taken = 0
    super
  end

  def take_a_seat
    self.seats -= 1
    self.seats_taken += 1
  end
end
