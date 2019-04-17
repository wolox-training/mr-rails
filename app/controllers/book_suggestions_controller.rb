class BookSuggestionsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  def create
    book_suggestion = BookSuggestion.new(create_book_suggestion_params)
    authorize book_suggestion
    book_suggestion.save!
    render json: book_suggestion, status: :created
  end

  private

  def create_book_suggestion_params
    params.require(:book_suggestion).permit(:user_id, :synopsis, :price, :author,
                                            :title, :link, :editor, :year)
  end
end
