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
end
