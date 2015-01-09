require "rails_helper"

RSpec.describe ActivityTemplatesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/activity_templates").to route_to("activity_templates#index")
    end

    it "routes to #new" do
      expect(:get => "/activity_templates/new").to route_to("activity_templates#new")
    end

    it "routes to #show" do
      expect(:get => "/activity_templates/1").to route_to("activity_templates#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/activity_templates/1/edit").to route_to("activity_templates#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/activity_templates").to route_to("activity_templates#create")
    end

    it "routes to #update" do
      expect(:put => "/activity_templates/1").to route_to("activity_templates#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/activity_templates/1").to route_to("activity_templates#destroy", :id => "1")
    end

  end
end
