class BooksController < ApplicationController
  include Wor::Paginate
  before_action :authenticate_user!
  def show
    @book = Book.find(params[:id])
  end

  def index
    render_paginated Book.all
  end
end
