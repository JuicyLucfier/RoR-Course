# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*names)
    value_history = '@value_history'

    names.each do |name|
      var_name = "@#{name}".to_sym

      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(value_history, {}) unless instance_variable_defined?(value_history)
        history = instance_variable_get(value_history)
        history[name] ||= []
        history[name] << value
        instance_variable_set(var_name, value)
      end

      define_method("#{name}_history") do
        var_history = instance_variable_get(value_history)
        return if var_history[name].nil? || var_history.nil?

        var_history[name]
      end
    end
  end

  def strong_attr_accessor(name, name_class)
    var_name = "@#{name}".to_sym

    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise 'Invalid type!' unless name_class == value.class

      instance_variable_set(var_name, value)
    end
  end
end
