# frozen_string_literal: true

# Cargo train
class CargoTrain < Train
  attr_accessor :type, :number

  def initialize(number, type = 'Грузовой')
    @number = number
    @type = type
    super
  end
end
