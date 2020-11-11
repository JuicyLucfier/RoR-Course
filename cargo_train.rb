# frozen_string_literal: true

# Cargo train
class CargoTrain < Train
  attr_accessor :type

  def initialize(number, type = 'Грузовой')
    super
  end
end
