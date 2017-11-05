ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/reporters"  # for Colorized output

VCR.configure do |config|
  config.cassette_library_dir = 'test/cassettes' # folder where casettes will be located
  config.hook_into :webmock # tie into this other tool called webmock
  config.default_cassette_options = {
    :record => :new_episodes,    # record new data when we don't have it yet
    :match_requests_on => [:method, :uri, :body] # The http method, URI and body of a request all need to match
  }
  # Don't leave our Slack token lying around in a cassette file.
  config.filter_sensitive_data("<EDAMOM_APP_ID>") do
    ENV['EDAMOM_APP_ID']
  end
  config.filter_sensitive_data("<EDAMOM_KEY>") do
    ENV['EDAMOM_KEY']
  end
end


#  For colorful output!
Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)


# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

def setup #runs once at the beginning of testing
  OmniAuth.config.test_mode = true
end

def mock_auth_hash(user)
  return {
    provider: user.provider,
    uid: user.uid,
    info: {
      name: user.name,
      email: user.email
    }
  }
end

def log_in(user, provider)
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(mock_auth_hash(user))
  # get auth_callback_path(provider)
  get google_login_path
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  # Add more helper methods to be used by all tests here...
end
