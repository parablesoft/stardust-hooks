class Stardust::Hooks::SubscriptionManager

  def self.create_subscriptions

    Stardust::Hooks::Hook.tracked_events_uniq.each do |event|
      create_subscription(event)
    end

    add_stardust_hooks_subscription_for_create
    add_stardust_hooks_subscription_for_update
    add_stardust_hooks_subscription_for_destroy
  end


  def self.add_stardust_hooks_subscription_for_create

    Stardust::Hooks::Subscription.new(
      event_name: "create",
      model: Stardust::Hooks::Hook
    ).subscribe do |e|

      e[:model].events.each do |event|
        if (!watched_events.include?(event))
          create_subscription(event)
        end
      end
    end
  end

  def self.add_stardust_hooks_subscription_for_update
    Stardust::Hooks::Subscription.new(
      event_name: "update",
      model: Stardust::Hooks::Hook
    ).subscribe do |e|
      if e[:changes].keys.include?("events")
        previous_events = e[:changes]["events"].first 
        items_removed = previous_events.select {|item| !e[:model].events.include?(item)}

        items_added = e[:model].events.select {|item| !previous_events.include?(item)}
        current_events = Stardust::Hooks::Hook.tracked_events_uniq

        items_added.each do |event|
          if !watched_events.include?(event)
            create_subscription(event)
          end
        end

        items_removed.each do |event|
          if !current_events.include?(event)
            remove_subscription(event)
          end
        end
      end
    end
  end

  def self.add_stardust_hooks_subscription_for_destroy
    Stardust::Hooks::Subscription.new(
      event_name: "destroy",
      model: Stardust::Hooks::Hook
    ).subscribe do |e|
      e[:model].events.each do |event|
        remove_subscription(event) if !Stardust::Hooks::Hook.tracked_events_uniq.include?(event)
      end
    end
  end

  def self.create_subscription(event)
    Stardust::Hooks::Subscription.new(event_name: event).subscribe do |e|

      event_name = e[:name]

      Stardust::Hooks::Hook
        .matching_hooks(e[:hook_scope],event_name)
        .each do |hook|

        Stardust::Hooks::HookHandler.new(
          hook: hook,
          event: e
        ).call

      end
    end
  end

  def self.remove_subscription(event_name)
    ActiveSupport::Notifications.unsubscribe(event_name)
  end

  def self.destroy_subscriptions
    Stardust::Hooks::Hook.tracked_events_uniq.each do |event|
      remove_subscription(event)
    end

    ["create","destroy","update"].each do |stardust_hook|
      remove_subscription("stardust_hooks.#{stardust_hook}")
    end

  end

  def self.watched_events
    ActiveSupport::Notifications
      .notifier
      .instance_variable_get("@subscribers")
      .map {|sub| sub.instance_variable_get("@pattern")}
  end

end



require_relative "subscription"
require_relative "hook_handler"
