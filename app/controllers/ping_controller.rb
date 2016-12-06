class PingController < ApplicationController
	def index
    @tests = {
      mysql: !!ActiveRecord::Base.connection.execute("select 1"),
      environment: Rails.env,
      ruby: RUBY_VERSION,
      internet: "definitely",
      path: Rails.root.split.last.to_s,
      reloaded: "yes it did reload thank you",
    }.with_indifferent_access
  end
end
