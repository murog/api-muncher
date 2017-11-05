require "test_helper"

describe SessionsController do
  describe "describe auth_callback" do
    it "should log in an existing user and redirect them to root" do
      start_count = User.count
      user = users(:crisco)
      log_in(user, :google_oauth2)
      must_respond_with :redirect
      User.count.must_equal start_count
      # session[:user_id].must_equal user.id
    end

    it "should create a new user if user hasn't logged in before" do
      start_count = User.count
      user = User.new name: "Greg", provider: 'github', email: 'RapMonster@naver.com', uid: "398509348"
      log_in(user, :google_oauth2)
      User.count.must_equal (start_count + 1)
    end

    it "should Successfully logout a user" do
      start_count = User.count
      user = users(:crisco)
      log_in(user, :google_oauth2)
      must_respond_with :redirect
      User.count.must_equal start_count
      get logout_path
      must_respond_with :redirect
    end
  end

end
