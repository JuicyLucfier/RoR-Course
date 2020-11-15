# frozen_string_literal: true

# Wagon
class Wagon
  include Company
  attr_accessor :type, :amount

  def initialize(_amount, type)
    @type = type
    valid!
  end

  def valid?
    valid!
  rescue StandardError
    false
  end

  protected

  def valid!
    raise "Type can't be nil!" if type.nil?
    raise 'Type must have at least 1 symbol!' if type.length.zero?
  end
end
