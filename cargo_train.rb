# frozen_string_literal: true

# Cargo train
class CargoTrain < Train
  attr_accessor :type

  def initialize(name, type = 'Грузовой')
    super
  end
end
