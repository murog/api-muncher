require 'test_helper'

class ChatControllerTest < ActionDispatch::IntegrationTest
  describe "search" do
    it "can get the list of recipes" do
      VCR.use_cassette("search_action") do
        post search_path, params: {search: "chicken"}
        must_respond_with :success
      end
    end

    # it "can get the list of channels on second page" do
    #   VCR.use_cassette("index_action") do
    #     get search_path, params: {search: "chicken"}
    #     must_respond_with :success
    #   end
    # end
  end

  describe "show" do
    it "can get a show page for a given recipe" do
      VCR.use_cassette("show_action") do
        vegatable_stew_uri = "e128b2dfab86d911618b669d499c4274"
        get show_recipe_path(vegatable_stew_uri)
        must_respond_with :success
      end
    end

    it "will render 404 for a bogus recipe" do
      VCR.use_cassette("show_action") do
        get show_recipe_path("bogus")
        must_respond_with :not_found
      end
    end
  end
end
