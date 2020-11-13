# frozen_string_literal: true

# InstanceCounter module
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # ClassMethods module
  module ClassMethods
    attr_accessor :instances_count

    def instances
      instances_count
    end
  end

  # InstanceMethods module
  module InstanceMethods
    protected

    def register_instances
      self.class.instances_count ||= 0
      self.class.instances_count += 1
    end
  end
end
