class RentsController < ApplicationController
  before_action :authenticate_user!, only: %i[index create]

  def index
    rents = policy_scope(Rent)
    render_paginated rents
  end

  def create
    rent = Rent.create!(create_rent_params)
    authorize rent
    render json: rent
    mail = UserMailer.notice_email(rent)
    mail.deliver_later
  end

  private

  def create_rent_params
    params.require(:rent).permit(:user_id, :book_id, :start_date, :end_date)
  end
end
