require 'test_helper'

describe EdamamApiWrapper do
  it "can list a group of recipes" do
    chicken_params  = {
      "query" => "chicken"
    }

    VCR.use_cassette("recipes_no_model") do
      recipes = EdamamApiWrapper.list_recipes(chicken_params)
      recipes.must_be_instance_of Array
      recipes.length.must_equal 10
      recipes.each {|recipe| recipe.must_be_instance_of Recipe}
    end
  end

  it "can list a group of recipes with multi-word query" do
    chicken_params  = {
      "query" => "chicken dumpling"
    }

    VCR.use_cassette("recipes_no_model") do
      recipes = EdamamApiWrapper.list_recipes(chicken_params)
      recipes.must_be_instance_of Array

      recipes.length.must_equal 10
    end
  end

  it "can list a group of recipes with a health restraint" do
    peanut_chicken_params = {
      "query" => "chicken",
      "health" => "peanut-free"
    }
    VCR.use_cassette("recipes_no_model") do
      recipes = EdamamApiWrapper.list_recipes(peanut_chicken_params)
      recipes.must_be_instance_of Array
      recipes.each do |recipe|
        recipe.health_labels.include? "alcohol-free"
      end
    end
  end
  it "will return [] for a broken request" do
    broken_request_params  = {
      "query" => ""
    }

    VCR.use_cassette("recipes_no_model") do
      recipes = EdamamApiWrapper.list_recipes(broken_request_params)
      recipes.must_be_instance_of Array

      recipes.length.must_equal 0
    end

  end
end
