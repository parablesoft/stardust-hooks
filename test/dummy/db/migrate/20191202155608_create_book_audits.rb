class CreateBookAudits < ActiveRecord::Migration[5.0]
  def change
    create_table :book_audits do |t|
      t.references :book, foreign_key: true
      t.string :test

      t.timestamps
    end
  end


  big_account = Account.first

  book_create_config = %q(
    hook do
      operation "book created" do

        condition true

        task do

          book = event[:model]
          BookAudit.create(book: book, test: "#{book.title} created")
        end
      end
    end
  )

  Stardust::Hooks::Hook.create(
    name: "Book Create",
    configuration: book_create_config,
    events: ["books.create"]
  )


  book_update_config = %q(
    hook do
      operation "book updated" do

        condition true

        task do

          book = event[:model]
          BookAudit.create(book: book, test: "#{book.title} updated")
        end
      end
    end
  )

  Stardust::Hooks::Hook.create(
    name: "Book Update",
    configuration: book_update_config,
    events: ["books.update"]
  )
  

  big_account_book_create_config = %q(
    hook do
      operation "book created for big account" do

        condition true

        task do

          book = event[:model]
          BookAudit.create(book: book, test: "#{book.title} created for big account")
        end
      end
    end
  )

  Stardust::Hooks::Hook.create(
    name: "Book Create",
    configuration: book_create_config,
    events: ["books.create"],
    referenceable: big_account
  )

end
