if ActiveRecord::Base.connection.table_exists? "stardust_hooks" 
  Stardust::Hooks::SubscriptionManager.create_subscriptions
end
