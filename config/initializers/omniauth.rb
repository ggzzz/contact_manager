Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, "a6a24e261858e9b47cfc", "905891f70455aaf155fcf5ae2b34be13f682b79a"
end