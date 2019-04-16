class BookSuggestionsController < ApplicationController
  def create
    book_suggestion = BookSuggestion.create!(create_book_suggestion_params)
    render json: book_suggestion, status: :created
  end

  private

  def create_book_suggestion_params
    params.require(:book_suggestion).permit(:user_id, :synopsis, :price, :author,
                                            :title, :link, :editor, :year)
  end
end
