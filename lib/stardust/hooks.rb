require "stardust/hooks/engine" 
require "sidekiq"
require_relative "hooks/configuration"

module Stardust
  module Hooks

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.configure
      yield(configuration)
    end
  end
end

require_relative "hooks/subscription_manager"
