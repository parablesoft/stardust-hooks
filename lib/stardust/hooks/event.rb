class Stardust::Hooks::Event < ActiveRecord::Base
  def self.table_name
    'stardust_events'
  end

  belongs_to :hook
end
