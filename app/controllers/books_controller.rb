class BooksController < ApplicationController
  before_action :set_excitement_page
  before_action :set_book , only: [:edit, :update, :show_image]

  def index
    @books = Book.where(excitement_page: @excitement_page)
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.excitement_page = @excitement_page
   
    if @book.save
      redirect_to excitement_page_books_path(excitement_page_id: @excitement_page), notice: 'Book was successfully created.'
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to excitement_page_books_path(excitement_page_id: @excitement_page), notice: 'Book was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private

    def set_excitement_page
      @excitement_page = ExcitementPage.find(params[:excitement_page_id])
    end

    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:name, :isbn)
    end

end