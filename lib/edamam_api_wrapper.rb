require 'httparty'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search?"
  APP_ID= ENV["EDAMAM_APP_ID"]
  APP_KEY = ENV["EDAMAM_KEY"]

  def self.list_recipes(input_params, app_key = nil)
    query = input_params["query"]
    input_params["health"] ? health = input_params["health"] : health = nil

    input_params["from"] ? from = input_params["from"] : from = 0
    input_params["to"] ? from = input_params["to"] : to = 10

    app_id = APP_ID
    app_key ||= APP_KEY

    url = BASE_URL + "q=#{query}" + "&app_id=#{app_id}&app_key=#{app_key}" + "&from=#{from}&to=#{to}"

    url += "&health=#{health}" if health

    data = HTTParty.get(url)
    # binding.pry
    if data["hits"]
      recipes = data["hits"]
      return recipes
    else
      return []
    end
  end
end
