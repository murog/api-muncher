require 'test_helper'

describe Recipe do
  it "can be created with only name and link" do
    my_recipe = Recipe.new "coffee", "coffee.com"
    my_recipe.must_respond_to :name
    my_recipe.must_respond_to :link
  end

  it "will raise error if given empty name or link" do
    proc {Recipe.new "", ""}.must_raise ArgumentError
    proc {Recipe.new nil, nil}.must_raise ArgumentError
    proc {Recipe.new "coffee"}.must_raise ArgumentError
    proc {Recipe.new }.must_raise ArgumentError
  end
  it "can be created with options" do
    my_recipe = Recipe.new "coffee", "coffee.com", {image: "cat.com/cat.gif", ingredients: [1,2,3], diet_info: ["lots", "of", "stuff"], health_labels: ["so", "many"], uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_e128b2dfab86d911618b669d499c4274" }
    my_recipe.must_respond_to :name
    my_recipe.must_respond_to :link
    my_recipe.image.must_equal "cat.com/cat.gif"
    my_recipe.ingredients.must_equal [1,2,3]
    my_recipe.dietary_information.must_equal ["lots", "of", "stuff"]
    my_recipe.health_labels.must_equal ["so", "many"]
    my_recipe.uri.must_equal "e128b2dfab86d911618b669d499c4274"
  end
end
