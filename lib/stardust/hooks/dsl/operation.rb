require_relative "./../helpers.rb"

module Stardust
  module Hooks
    class DSL
      class Operation

        include Stardust::Hooks::Helpers


        attr_reader :name

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

      end
    end
  end
end
