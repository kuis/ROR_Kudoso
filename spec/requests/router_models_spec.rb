require 'rails_helper'

RSpec.describe "RouterModels", type: :request do
  describe "GET /router_models" do
    it "works! (now write some real specs)" do
      get router_models_path
      expect(response).to have_http_status(200)
    end
  end
end
