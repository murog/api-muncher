require "test_helper"

describe User do
  let(:user) { User.new }

  it "must not be valid without name, email, or uid" do
    user.valid?.must_equal false
    user.name = "crisco"
    user.valid?.must_equal false
    user.email = "crisco@google.net"
    user.valid?.must_equal false
    user.uid = "053809"
    user.valid?.must_equal true
  end
  it "must not be valid if another user exists with that email" do
    user = users(:crisco)
    user.valid?.must_equal true
    user.email = users(:chocolate_bar).email
    user.valid?.must_equal false
  end

  it "must be initialized with an empty array of recent searches" do
    user.recent_searches.must_be_instance_of Array
    user.recent_searches.length.must_equal 0

  end

  it "must be initialized with an empty array of favorites" do
    user.favorites.must_be_instance_of Array
    user.favorites.length.must_equal 0
  end

  describe "update_recent_searches" do
    it "should retain last search item and delete first if length is greater than 5" do
      user = users(:crisco)
      user.recent_searches.must_be_instance_of Array
      user.recent_searches.length.must_equal 5
      user.recent_searches.must_equal ["water", "bacon", "strawberry", "garbage", "soy"]

      user.recent_searches << "steak"

      user.update_recent_searches
      user.save.must_equal true
      user.recent_searches.must_be :!=, ["water", "bacon", "strawberry", "garbage", "soy"]
      user.recent_searches.length.must_equal 5
    end

    it "should not do anything if user has 5 or less items in recent_searches" do
      user = users(:chocolate_bar)
      user.recent_searches.must_be_instance_of Array
      user.recent_searches.length.must_equal 3


      user.recent_searches << "steak"

      user.update_recent_searches.must_equal false
      user.save.must_equal true
      user.recent_searches.must_include "steak"
      user.recent_searches.length.must_be :>, 3

    end

  end
end
