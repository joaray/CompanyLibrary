class BooksController < ApplicationController

before_action :set_book, except: [:new, :create, :index]
before_action :set_user, except: [:index]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(check_params)
	  if @book.save
      redirect_to root_url,
      notice: 'Book has been added'
    else
      flash.now[:alert] = "Give title and author"
      render "new"
    end
  end

  def edit
  end

  def update
    if @book.update(check_params)
      redirect_to root_url,
      notice: "Book has been changed"
    else
      flash.now[:alert] = "Give title and author"
      render 'edit'
    end
  end

  def destroy
    @book.destroy
    redirect_to root_url
  end

  def index
    @books=Book.all
  end

  def show
  end

  def borrow
    @loan = Loan.new(
      book: @book,
      user: current_user,
      status: Book::STATUS_BORROWED
    )
    if @loan.save!
      redirect_to book_path(@book),
      notice: 'Book has been borrowed'
    else
      render root_url
    end
  end

  def return
    borrower = @book.loans.where(status: Book::STATUS_BORROWED).order(created_at: :desc).first.user
    @loan = Loan.new(
      book: @book,
      user: borrower,
      status: Book::STATUS_RETURNED
    )
    if @loan.save!
      redirect_to book_path(@book),
        notice: 'Book has been returned'
    else
      render root_url
    end
  end

  private

  def check_params
    params.require(:book).permit(:title, :author, :publishing_date)
  end

  def set_book
      @book = Book.find(params[:id])
  end

  def set_user
    unless user_signed_in?
      redirect_to root_url
    end
  end


end
