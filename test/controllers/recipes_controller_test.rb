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
end
