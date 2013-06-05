OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, SchoolBlogConfig::FacebookID, SchoolBlogConfig::FacebookSecret
end