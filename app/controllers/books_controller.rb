class BooksController < ApplicationController
  include Wor::Paginate
  before_action :authenticate_user!
  def show; end

  def index
    render_paginated Book
  end
end
