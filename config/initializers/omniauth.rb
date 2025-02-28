Rails.application.config.middleware.use OmniAuth::Builder do
  provider :marvin, ENV["FORTYTWO_UID"], ENV["FORTYTWO_SECRET"]
end
