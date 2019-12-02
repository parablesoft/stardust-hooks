class CreateEvents < ActiveRecord::Migration[5.0]
  def change

    create_table :stardust_events do |t|
      t.references :hook
      t.text :content
    end
  end
end


