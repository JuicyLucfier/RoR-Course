# frozen_string_literal: true

# Wagon
class Wagon
  include Company
  attr_accessor :type

  def initialize(type)
    @type = type
  end
end
