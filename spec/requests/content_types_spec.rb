require 'rails_helper'

RSpec.describe "ContentTypes", :type => :request do
  describe "GET /content_types" do
    it "works! (now write some real specs)" do
      skip('build valid requests')
      get content_types_path
      expect(response).to have_http_status(200)
    end
  end
end
