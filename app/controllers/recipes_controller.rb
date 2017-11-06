class RecipesController < ApplicationController
  def search
    # recipe_data["info"] = ({more: data["more"], count: data["count"], url: url})
    @results  = EdamamApiWrapper.list_recipes(params)
    @recipes = @results["recipes"]
    @more = @results["info"][:more]
    @count = @results["info"][:count].to_i
    @pages = @count/10
    @from = params["from"]
    @to = params["to"]
    @current_page = 1
    if @user
    end
  end
  def pages
    @current_page = params["id"].to_i
    @pages = params[:pages].to_i
    @results  = EdamamApiWrapper.list_recipes(params)
    @recipes = @results["recipes"]
    @from = params[:from]
    @to = params[:to]
  end

  def show
    @recipe = EdamamApiWrapper.find_recipe(params[:id])
    if !(@recipe)
      render_404
    end

  end

  def add_to_favorites
    @recipe = EdamamApiWrapper.find_recipe(params[:id])
    if !(@recipe)
      render_404
    end
    if @user
      @user.add_to_favorites(@recipe.uri)
      @user.save
    else
      flash[:error] = "Try logging in to save a recipe to your favorites!"
      redirect_to show_recipe_path(@recipe.uri)
    end
  end
  private
  def render_404
    render file: "/public/404.html", status: 404
    return
  end
end
