class RentsController < ApplicationController
  include Wor::Paginate
  before_action :authenticate_user!, only: %i[index create]

  def index
    render_paginated Rent.all
  end

  def create
    rent = Rent.create!(params.require(:rent).permit(:user_id, :book_id, :start_date, :end_date))
    render json: rent
  end
end
