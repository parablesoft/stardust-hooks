module Stardust
  module Hooks
    module Workers

      class AsyncWorker
        include ::Sidekiq::Worker

        def perform(event_id)
          # puts Book.first.title
          # puts Account.first.name
          @event_id = event_id
          process_event
          destroy_event
        end

        private

        attr_reader :event_id

        def event_data
          @event_data ||= Stardust::Hooks::Event.find(event_id)
        end

        def event
          # @event ||= YAML.load(event_data.content)
          @event ||= Marshal.load(event_data.content)
        end

        def hook
          @hook ||= event_data.hook
        end

        def process_event
          dsl.instance_eval(configuration)
        end

        def destroy_event
          event_data.destroy
        end

        def dsl
          @dsl ||= Stardust::Hooks::DSL.new(event)
        end

        def configuration
          @configuration ||= hook.configuration
        end
      end
    end
  end
end

