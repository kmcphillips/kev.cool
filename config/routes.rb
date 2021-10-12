Rails.application.routes.draw do
  root to: "ping#index"

  require "sidekiq/web"
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(Rails.application.secrets[:sidekiq_admin_username])) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(Rails.application.secrets[:sidekiq_admin_password]))
  end
  mount Sidekiq::Web, at: "/sidekiq"
end
