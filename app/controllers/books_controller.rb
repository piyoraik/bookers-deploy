class BooksController < ApplicationController
  def index
    @book = Book.new
    @books = Book.all
  end

  def show
    @book_show = Book.find(params[:id]) 
    @user = @book_show.user
    @book = Book.new

  end

  def  create
      @book = Book.new(book_params)      #空のオブジェクトを渡して新規登録から持ってきた情報をbook_paramsに渡している。
      @book.user_id = current_user.id      #誰が投稿したかがわかるようにuser.idが今ログインしているしている人(curret)を指定
      if @book.save
      redirect_to book_path(@book.id), notice: 'Book was successfully created'
    else
      @books = Book.all
      render :index
    end
  end

  def new
  end

  def edit
  @book = Book.find(params[:id])
  end

  def destroy
  book = Book.find(params[:id])
  book.destroy
  redirect_to books_path, notice: 'Book was successfully destroy'
  end

  def update
  book = Book.find(params[:id])
  book.update(book_params)
  redirect_to book_path(book.id), notice: 'Book was successfully created'
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end