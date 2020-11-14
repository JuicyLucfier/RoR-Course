# frozen_string_literal: true

# Wagon
class Wagon
  include Company
  attr_accessor :type

  def initialize(type)
    @type = type
    valid!
  end

  def valid?
    valid!
  rescue
    false
  end

  protected

  def valid!
    raise "Type can't be nil!" if type.nil?
    raise "Type must have at least 1 symbol!" if type.length == 0
  end
end
