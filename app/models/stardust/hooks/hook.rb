class Stardust::Hooks::Hook < ActiveRecord::Base

  include Publishable

  # belongs_to :dealer, optional: true

  def self.table_name
    'stardust_hooks'
  end

  scope :matching_hooks,  -> (dealer_id,event_name) do
    # where("dealer_id = ? or dealer_id is null", dealer_id)
    where('events @> ARRAY[?]::text[]', Array(event_name))
  end

  def self.tracked_events_uniq
    pluck(:events).flatten.uniq
  end

  private

  def hook_scope
    nil
  end

end
