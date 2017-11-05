class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :find_user

  def index

  end

  private
  def find_user
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
    end
  end

end
