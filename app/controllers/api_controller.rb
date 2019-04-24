class ApiController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_user!
end
