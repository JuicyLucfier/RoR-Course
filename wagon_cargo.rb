# frozen_string_literal: true

# Cargo Wagon
class WagonCargo < Wagon
  attr_accessor :type, :volume, :volume_taken

  def initialize(volume, type = 'Грузовой')
    @volume = volume
    @volume_taken = 0
    super
  end

  def take_volume(volume_value)
    raise 'Invlaid volume value!' if (volume - volume_value).negative?

    self.volume -= volume_value
    @volume_taken += volume_value
  end
end
