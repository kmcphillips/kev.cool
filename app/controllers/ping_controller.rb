class PingController < ApplicationController
	def index
    @tests = {
      mysql: !!ActiveRecord::Base.connection.execute("select 1"),
      internet: "definitely",
    }.with_indifferent_access
  end
end
