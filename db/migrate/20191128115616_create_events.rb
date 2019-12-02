class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    unless table_exists?(:stardust_events)
      create_table :stardust_events do |t|
        t.references :hook
        t.binary :content
      end
    end
  end
end


