# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PingController, type: :controller do
  describe "GET#index" do
    it "has a list of tests" do
      get :index
      expect(response).to be_ok
      expect(assigns(:tests).keys.sort).to eq(["mysql", "environment", "redis", "ruby", "release"].sort)
    end
  end
end
