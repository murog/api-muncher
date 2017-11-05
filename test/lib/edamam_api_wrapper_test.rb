require 'test_helper'

describe EdamamApiWrapper do
  it "can list a group of recipes" do
    chicken_params  = {
      "query" => "chicken"
    }

    VCR.use_cassette("list_recipes") do
      recipe_data = EdamamApiWrapper.list_recipes(chicken_params)
      recipe_data["recipes"].must_be_instance_of Array
      recipe_data["recipes"].length.must_equal 10
      recipe_data["recipes"].each {|recipe| recipe.must_be_instance_of Recipe}
    end
  end

  it "can list a group of recipes with multi-word query" do
    chicken_params  = {
      "query" => "chicken dumpling"
    }

    VCR.use_cassette("list_recipes") do
      recipe_data = EdamamApiWrapper.list_recipes(chicken_params)
      recipe_data["recipes"].must_be_instance_of Array

      recipe_data["recipes"].length.must_equal 10
    end
  end

  it "can list a group of recipes with a health restraint" do
    peanut_chicken_params = {
      "query" => "chicken",
      "health" => "peanut-free"
    }
    VCR.use_cassette("list_recipes") do
      recipe_data = EdamamApiWrapper.list_recipes(peanut_chicken_params)
      recipe_data["recipes"].must_be_instance_of Array
      recipe_data["recipes"].each do |recipe|
        recipe.health_labels.include? "alcohol-free"
      end
    end
  end
  it "will return [] for a broken request" do
    broken_request_params  = {
      "query" => ""
    }

    VCR.use_cassette("list_recipes") do
      recipe_data = EdamamApiWrapper.list_recipes(broken_request_params)
      recipe_data["recipes"].must_be_instance_of Array

      recipe_data["recipes"].length.must_equal 0
    end

  end

  it "will return list based on to and from params" do
    chicken_params  = {
      "query" => "chicken",
      "to" => "12",
      "from" =>"11"
    }
    VCR.use_cassette("list_recipes") do
      recipe_data = EdamamApiWrapper.list_recipes(chicken_params)
      recipe_data["recipes"].must_be_instance_of Array
      recipe_data["recipes"].length.must_equal 1
      recipe_data["recipes"].each {|recipe| recipe.must_be_instance_of Recipe}
    end
  end
  it "can find one recipe when given a uri" do
    vegatable_stew_uri = "e128b2dfab86d911618b669d499c4274"
    VCR.use_cassette("find_recipe") do
      recipe_data = EdamamApiWrapper.find_recipe(vegatable_stew_uri)
      recipe_data.must_be_instance_of Recipe
    end
  end
end
