class CreateHooks < ActiveRecord::Migration[5.0]
  def change
    unless table_exists?(:stardust_hooks)
      create_table :stardust_hooks do |t|
        t.string :name
        t.string :target_url
        t.references :referenceable, polymorphic: true, index: true
        t.text :configuration
        t.text  :events, array: true, default: []
      end
    end

  end
end
