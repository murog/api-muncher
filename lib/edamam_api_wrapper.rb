require 'httparty'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  APP_ID= ENV["EDAMAM_APP_ID"]
  APP_KEY = ENV["EDAMAM_KEY"]

  def self.list_recipes(input_params, app_key = nil)
    query = input_params["query"]
    input_params["health"] ? health = input_params["health"] : health = nil

    input_params["from"] ? from = input_params["from"] : from = 0
    input_params["to"] ? to = input_params["to"] : to = 10

    app_id = APP_ID
    app_key ||= APP_KEY

    url = BASE_URL + "q=#{query}" + "&app_id=#{app_id}&app_key=#{app_key}" + "&from=#{from}&to=#{to}"

    url += "&health=#{health}" if health

    data = HTTParty.get(url)
    # binding.pry
    if data["hits"]
      list = []
      recipes = data["hits"]
      # binding.pry
      recipes.each do |recipe|
        list << (Recipe.new recipe["recipe"]["label"], recipe["recipe"]["url"], {image: recipe["recipe"]["image"], ingredients: recipe["recipe"]["ingredients"], diet_info: recipe["recipe"]["totalNutrients"], health_labels: recipe["recipe"]["healthLabels"], uri: recipe["recipe"]["uri"]})
      end
      recipe_data = {}
      recipe_data["info"] = ({more: data["more"], count: data["count"], url: url})
      recipe_data["recipes"] = list
      return recipe_data
    else
      return []
    end
  end

  def self.find_recipe(input_uri)

    # uri = input_uri.gsub("#", "%23")

    url = BASE_URL + "r=http://www.edamam.com/ontologies/edamam.owl%23recipe_#{input_uri}"

    data = HTTParty.get(url)
    # binding.pry
    if data.length > 0
      recipe = data.first
      recipe = Recipe.new recipe["label"], recipe["url"], {image: recipe["image"], ingredients: recipe["ingredients"], diet_info: recipe["totalNutrients"], health_labels: recipe["healthLabels"], uri: recipe["uri"]}
      return recipe
    else
      return false
    end
  end

end
