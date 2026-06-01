OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?

  auth0_domain = ENV['AUTH0_DOMAIN']
  auth0_user_info_domain = ENV.fetch('AUTH0_USER_INFO_DOMAIN', auth0_domain)

  provider(
    :auth0,
    ENV['AUTH0_CLIENT_ID'],
    ENV['AUTH0_CLIENT_SECRET'],
    auth0_domain,
    callback_path: '/auth/auth0/callback',
    authorize_params: {
      scope: 'openid profile',
      audience: "https://#{auth0_user_info_domain}/userinfo"
    }
  )
end
