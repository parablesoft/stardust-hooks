class BooksController < ApplicationController


  def new
    @book = Book.new
    @book_count = Book.count
  end

  def create

    Book.create(
    title: "Foo",
    author: "Bar"
    )


    redirect_to new_book_url
  end
end
