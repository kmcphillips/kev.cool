require 'rails_helper'

RSpec.describe PingController, type: :controller do
  describe "GET#index" do
    it "has a list of tests" do
      get :index
      expect(response).to be_ok
      expect(assigns(:tests).keys).to eq(["mysql", "environment", "ruby", "release"])
    end
  end
end
