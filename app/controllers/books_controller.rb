class BooksController < ApplicationController
  before_action :authenticate_user!, only: %i[show index]
  def show
    book = Book.find(book_id)
    render json: book
  end

  def index
    render_paginated Book.all
  end

  private

  def book_id
    params.require(:id)
  end
end
