# frozen_string_literal: true

# Cargo Wagon
class WagonCargo < Wagon
  attr_accessor :type

  def initialize(type = 'Грузовой')
    @type = type
    super
  end
end
