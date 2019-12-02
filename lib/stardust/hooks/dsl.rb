require 'method_source'

module Stardust
  module Hooks
    class DSL

      def initialize(event)
        @event = event
      end

      def hook(&block)
        if block_given?
          @hook = Stardust::Hooks::DSL::Hook.new
            .with(event)

          @hook.instance_eval(&block)
        else
          @hook
        end
      end

      private
      attr_reader :event
    end
  end
end


require_relative 'dsl/hook'
