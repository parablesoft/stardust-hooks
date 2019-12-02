class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :name

      t.timestamps
    end


    Account.create(name: "Big Account")
    Account.create(name: "Little Account")
  end
end
