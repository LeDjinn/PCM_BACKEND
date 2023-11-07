require "rails_helper"

RSpec.describe LossesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/losses").to route_to("losses#index")
    end

    it "routes to #new" do
      expect(get: "/losses/new").to route_to("losses#new")
    end

    it "routes to #show" do
      expect(get: "/losses/1").to route_to("losses#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/losses/1/edit").to route_to("losses#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/losses").to route_to("losses#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/losses/1").to route_to("losses#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/losses/1").to route_to("losses#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/losses/1").to route_to("losses#destroy", id: "1")
    end
  end
end
