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
end
