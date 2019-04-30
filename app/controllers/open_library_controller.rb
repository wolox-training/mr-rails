class OpenLibraryController < ApiController
  def index
    book = book_request
    if book.empty?
      render json: book, status: 404
    else
      render json: book, status: 200
    end
  end

  private

  def book_request
    OpenLibrary.new.show(isbn_param)
  end

  def isbn_param
    params.require(:isbn)
  end
end
