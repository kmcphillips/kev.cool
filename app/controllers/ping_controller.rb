class PingController < ApplicationController
	def index
    @tests = {
      mysql: ActiveRecord::Base.connection.execute("SELECT 1").to_a.first ? "SELECT 1" : false,
      redis: Redis.new(url: ENV.fetch("REDIS_URL") { "redis://localhost:6379/1" }).ping == "PONG" ? "PONG" : false,
      environment: Rails.env,
      ruby: RUBY_VERSION,
      release: Rails.root.split.last.to_s,
    }.with_indifferent_access

    @tests[:fly] = "#{ ENV["FLY_ALLOC_ID"] } #{ ENV["FLY_REGION"] }" if ENV["FLY_ALLOC_ID"].present?
  end
end
