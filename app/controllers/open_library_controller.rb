class OpenLibraryController < ApiController
  def index
    book = book_request
    raise ActiveRecord::RecordNotFound if book.empty?

    render json: book
  end

  private

  def book_request
    OpenLibrary.new.show(isbn_param)
  end

  def isbn_param
    params.require(:isbn)
  end
end
