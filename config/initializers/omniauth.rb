Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '775270130905-k5t4j0ie88q0pui2p9c3gcv17ehijtqk', '4pabZAKSewPa9ltQB01yP73C', provider_ignores_state: true
end
OmniAuth.config.on_failure = SessionsController.action(:oauth_failure)
