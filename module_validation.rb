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
        send("validate_#{args[0]}", name, *args[1..args.length])
      end
    end

    def valid?
      validate!
    rescue StandardError
      false
    end

    private

    def validate_presence(name)
      value = instance_variable_get("@#{name}")
      raise "Attribute's value is nil or empty string!" if value.nil? || value.empty?
    end

    def validate_format(name, format)
      value = instance_variable_get("@#{name}")
      raise 'Invalid value!' if value !~ format
    end

    def validate_type(name, type)
      class_type = instance_variable_get("@#{name}")
      raise 'Invalid type!' if class_type != type
    end
  end
end
