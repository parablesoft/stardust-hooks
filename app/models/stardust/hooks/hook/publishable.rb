module Stardust::Hooks::Hook::Publishable
  extend ActiveSupport::Concern

  included do
    after_commit :publish_create, on: :create
    after_commit :publish_update, on: :update
    after_commit :publish_destroy, on: :destroy
  end



  class_methods do
    def subscribe(event = :any)
      event_name = event == :any ? /#{table_name}/ : "#{table_name}.#{event}"
      ActiveSupport::Notifications.subscribe(event_name) do |_event_name, **payload|
        yield payload
      end
    end
  end

  private

  def publish_create
    publish(:create)
  end

  def publish_update
    publish(:update,previous_changes) if changes_to_publishable_attributes?

  end

  def publish_destroy
    publish(:destroy)
  end

  def changes_to_publishable_attributes?
    previous_changes.keys.map(&:to_sym).any? {|key| publishable_attributes.include?(key)}
  end

  def hook_scope
    raise NotImplementedError
  end

  def publishable_attributes
    attributes.keys.map &:to_sym
  end

  def publish(event,changes={})

    event_name = "#{self.class.table_name}.#{event}"
    ActiveSupport::Notifications.publish(
      event_name, 
      event: event, 
      model: self,
      changes: changes,
      hook_scope: hook_scope,
      name: event_name
    )
  end
end
