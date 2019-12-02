class CreateBookAudits < ActiveRecord::Migration[5.0]
  def change
    create_table :book_audits do |t|
      t.references :book, foreign_key: true
      t.string :test

      t.timestamps
    end
  end
end
