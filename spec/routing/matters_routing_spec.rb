require "rails_helper"

RSpec.describe MattersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/matters").to route_to("matters#index")
    end

    it "routes to #new" do
      expect(get: "/matters/new").to route_to("matters#new")
    end

    it "routes to #show" do
      expect(get: "/matters/1").to route_to("matters#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/matters/1/edit").to route_to("matters#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/matters").to route_to("matters#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/matters/1").to route_to("matters#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/matters/1").to route_to("matters#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/matters/1").to route_to("matters#destroy", id: "1")
    end
  end
end
