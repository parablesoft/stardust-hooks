class CreateHooks < ActiveRecord::Migration[5.0]
  def change
    create_table :stardust_hooks do |t|
      t.string :name
      t.string :target_url
      # t.references :dealer
      t.text :configuration
      t.text  :events, array: true, default: []
    end
  end
end


