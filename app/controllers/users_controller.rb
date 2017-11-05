class UsersController < ApplicationController
  def index
  end

  def show
  end
  
  def favorites
    if !(@user)
      render_404
    end
    find_favorites
  end

  private
  def find_user
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
    end
  end

  def render_404
    render file: "/public/404.html", status: 404
    return
  end

  def find_favorites
    @favorites = []
    @user.favorites.each do |uri|
      recipe = EdamamApiWrapper.find_recipe(uri)
      @favorites << recipe
    end
  end
end
