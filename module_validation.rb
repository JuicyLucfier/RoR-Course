# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, *args)
      validate_name = '@validate_name'
      instance_variable_set(validate_name, {}) unless instance_variable_defined?(validate_name)
      validation_list = instance_variable_get(validate_name)
      validation_list[name] = *args
    end
  end

  module InstanceMethods
    def validate!
      self.class.instance_variable_get('@validate_name').each do |name, args|
        var_name = instance_variable_get("@#{name}")
        send("validate_#{args[0]}", var_name, *args[1..args.length])
      end
    end

    def valid?
      validate!
    rescue StandardError
      false
    end

    private

    def validate_presence(var_name)
      raise "Attribute's value is nil or empty string!" if var_name.nil? || var_name.empty?
    end

    def validate_format(var_name, format)
      raise 'Invalid value!' if var_name !~ format
    end

    def validate_type(var_name, type)
      raise 'Invalid type!' if var_name != type
    end
  end
end
