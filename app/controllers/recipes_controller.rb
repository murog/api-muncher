class RecipesController < ApplicationController
  def search
    @results  = EdamamApiWrapper.list_recipes(params)
    @recipes = @results["recipes"]
  end
end
