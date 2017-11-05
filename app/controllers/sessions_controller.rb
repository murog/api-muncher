class SessionsController < ApplicationController
  def create

    @auth_hash = request.env['omniauth.auth']
    @user = User.find_by(uid: @auth_hash['uid'].to_i, provider: @auth_hash['provider'])
    if @user
      session[:user_id] = @user.id
      flash[:success] = "Welcome #{@user.name}"
    else
      @user = User.new uid: @auth_hash['uid'], provider: @auth_hash['provider'], name: @auth_hash['info']['name'], email: @auth_hash['info']['email']
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Welcome #{@user.name}"
      else
        flash[:error] = "Unable to save user!!!"
      end
    end
    redirect_to root_path

  end

  def logout
    session[:user_id] = nil
    flash[:result_text] = "Successfully logged out!"
    redirect_to root_path
  end
end
