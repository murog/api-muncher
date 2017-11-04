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
    @results = EdamamApiWrapper.find_recipe(params[:id])
    if !(@results)
      render_404
    end

  end
  private
  def render_404
    render file: "/public/404.html", status: 404
    return
  end
end
