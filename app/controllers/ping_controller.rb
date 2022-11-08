class PingController < ApplicationController
	def index
    @tests = {
      mysql: ActiveRecord::Base.connection.execute("SELECT 1").to_a.first ? "SELECT 1" : false,
      redis: Redis.current.ping == "PONG" ? "PONG" : false,
      environment: Rails.env,
      ruby: RUBY_VERSION,
      release: Rails.root.split.last.to_s,
    }.with_indifferent_access
  end
end
