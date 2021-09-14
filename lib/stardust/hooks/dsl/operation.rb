require_relative "./../helpers.rb"

module Stardust
  module Hooks
    class DSL
      class Operation
        attr_reader :name

        include Stardust::Hooks::Helpers

        def initialize(name=nil)
          @name = name
          @tasks = []
        end

        def with(event)
          @event = event
          self
        end

        def task(&block)
          instance_eval(&block)  if should_run_task?
        end

        def should_run_task?
          if condition.is_a?(Proc)
            instance_exec(&condition)
          else
            condition
          end
        end

        def model
          event[:model]
        end

        def condition(condition = nil, &block)
          if block_given?
            @condition = block
          elsif !condition.nil?
            @condition = condition
          else
            !@condition.nil? ? @condition : true
          end
        end

        private 
        attr_reader :event

        def method_missing(method, args)
          m = method.to_s
          if m.starts_with?(FIELD_CHANGED_PREFIX)
            field = m.split(FIELD_CHANGED_PREFIX).last
            field_changed(field, args)
          else
            super(method)
          end
        end

        FIELD_CHANGED_PREFIX = "change_to_"

        def field_changed(field, field_value)
          model = event[:model]
          event[:changes].has_key?(field) &&
            if field_value.is_a?(Hash)
              event[:changes][field].first == field_value[:from] &&
              event[:changes][field].last == field_value[:to]
            else
              model[field] == field_value
            end
        end
      end
    end
  end
end
