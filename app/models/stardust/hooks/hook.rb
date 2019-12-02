class Stardust::Hooks::Hook < ActiveRecord::Base

  include Publishable

  belongs_to :referenceable, optional: true, polymorphic: true

  def self.table_name
    'stardust_hooks'
  end

  scope :matching_hooks,  -> (referenceable,event_name) do
    where("(referenceable_id = ? and referenceable_type = ?) or referenceable_id is null", 
          referenceable.try(:id), 
          referenceable.try(:class).try(:name)
         )
      .where('events @> ARRAY[?]::text[]', Array(event_name))
  end

  def self.tracked_events_uniq
    pluck(:events).flatten.uniq
  end

  private

  def hook_scope
    nil
  end

end
