Rails.application.routes.draw do
  root to: "ping#index"

  require "sidekiq/web"
  Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(Rails.application.secrets[:sidekiq_admin_username])) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(Rails.application.secrets[:sidekiq_admin_password]))
  end
  mount Sidekiq::Web, at: "/sidekiq"
end
