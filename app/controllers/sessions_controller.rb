class SessionsController < ApplicationController
  def new
    render :text => flash[:alert]
  end
end
