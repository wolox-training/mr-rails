class RentsController < ApplicationController
  before_action :authenticate_user!, only: %i[index create]

  def index
    render_paginated Rent.all
  end

  def create
    rent = Rent.create!(create_rent_params)
    render json: rent
  end

  private

  def create_rent_params
    params.require(:rent).permit(:user_id, :book_id, :start_date, :end_date)
  end
end
