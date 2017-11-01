require 'httparty'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  TOKEN = ENV["EDAMAM_TOKEN"]
end
