class RecipesController < ApplicationController
  # def search
  #   # recipe_data["info"] = ({more: data["more"], count: data["count"], url: url})
  #   @results  = EdamamApiWrapper.list_recipes(params)
  #   @recipes = @results["recipes"]
  #   @more = @results["info"][:more]
  #   @count = @results["info"][:count].to_i
  #   !(params[:pages]) ? (@pages = @count/10) : (@pages = params[:pages].to_i)
  #   set_boundaries
  #   # @current_page = 1
  #   add_recent_search
  # end
  def pages
    # @current_page = params["id"].to_i
    @results  = EdamamApiWrapper.list_recipes(params)
    @count = @results["info"][:count].to_i
    !(params[:pages]) ? (@pages = @count/10) : (@pages = params[:pages].to_i)
    @recipes = @results["recipes"]
    set_boundaries
    add_recent_search
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
      if @user.included_in_favorites?(@recipe.uri)
        flash[:error] = "You have already faved this recipe."
      else
        @user.add_to_favorites(@recipe.uri)
        if @user.save
          flash[:result] = "Successfully added #{@recipe.name} to your favorites (-:"
        else
          @user.errors.each {|key, value| flash["#{key}"] = "#{value}"}
        end
      end
    else
      flash[:error] = "Try logging in to save a recipe to your favorites!"
    end
    redirect_back(fallback_location: root_path)
  end

  def remove_from_favorites
    if !(@user)
      render_404
    end
    @recipe = EdamamApiWrapper.find_recipe(params[:id])
    if !(@recipe)
      render_404
    end
    if @user.remove_from_favorites(@recipe.uri)
      if @user.save
        flash[:result] = "Successfully removed #{@recipe.name} from your favorites (-:"
      else
        @user.errors.each {|key, value| flash["#{key}"] = "#{value}"}
      end
    else
      flash[:error] = "Uh oh! Something went wrong )-:"
    end
    redirect_back(fallback_location: root_path)
  end

  private
  def set_boundaries
    if !(params[:from])
      @from = 0
      @to = 10
    else
      @from = params[:from].to_i
      @to = params[:to].to_i
    end
    if !(params["id"])
      @current_page = 1
    else
      @current_page = params["id"].to_i
    end
  end

  def add_recent_search
    if @user
      if !(@user.recent_searches.include? params["query"])
        @user.recent_searches << params["query"]
        @user.update_recent_searches
        @user.save
      end
    end
  end

  def render_404
    render file: "/public/404.html", status: 404
    return
  end
end
