class PingController < ApplicationController
	def index
    @tests = {
      mysql: !!ActiveRecord::Base.connection.execute("select 1"),
      environment: Rails.env,
      ruby: RUBY_VERSION,
      internet: "definitely",
    }.with_indifferent_access
  end
end
