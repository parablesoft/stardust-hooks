class BooksController < ApplicationController


  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
   @book = Book.create(create_params)
    redirect_to @book
  end

  def show
    @book = Book.find(params[:id])
  end

  private

  def create_params

    params.require(:book).permit(
      :author, 
      :account_id, 
      :title
    )
  end
end
