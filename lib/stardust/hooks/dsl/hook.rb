module Stardust
  module Hooks
    class DSL
      class Hook

        attr_reader :operations
        def initialize(event=nil)
          @operations = []
        end

        def with(event)
          @event = event
          self
        end

        def operation(name,&block)
          operation = Stardust::Hooks::DSL::Operation.new(name)
            .with(event)

          if block_given?
            operation.instance_eval(&block)
          end

          @operations << operation
        end

        private

        attr_reader :event
      end
    end
  end
end


require_relative "operation"
