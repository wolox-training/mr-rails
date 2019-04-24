class ApplicationController < ActionController::Base
  include Wor::Paginate
  include Pundit
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: exception.message, status: :not_found
  end
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(error)
    render json: { error: error.message }, status: :unauthorized
  end
end
