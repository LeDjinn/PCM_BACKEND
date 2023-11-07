require "rails_helper"

RSpec.describe TubesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/tubes").to route_to("tubes#index")
    end

    it "routes to #new" do
      expect(get: "/tubes/new").to route_to("tubes#new")
    end

    it "routes to #show" do
      expect(get: "/tubes/1").to route_to("tubes#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/tubes/1/edit").to route_to("tubes#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/tubes").to route_to("tubes#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/tubes/1").to route_to("tubes#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/tubes/1").to route_to("tubes#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/tubes/1").to route_to("tubes#destroy", id: "1")
    end
  end
end
