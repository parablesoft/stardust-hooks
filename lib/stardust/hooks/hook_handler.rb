class Stardust::Hooks::HookHandler

  def initialize(
    hook:,
    event: 
  )
    @hook = hook
    @event = event
  end

  def call
    Stardust::Hooks::Workers::AsyncWorker.perform_async(stored_event.id)
  end

  private

  attr_reader :hook,
    :event

  def stored_event
    @stored_event ||= Stardust::Hooks::Event.create!(
      hook: hook,
      content: Marshal.dump(event)
    )
  end


end

require_relative "dsl"
require_relative "workers/async_worker"
