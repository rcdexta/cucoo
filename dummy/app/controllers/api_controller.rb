require_relative 'application_controller'

class ApiController < ApplicationController

  def index
    render json: {message:'success'}
  end

end