Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
  OmniAuth.config.full_host = Rails.env.production? ? 'https://gm-muncher.herokuapp.com' : 'http://localhost:3000'

end
