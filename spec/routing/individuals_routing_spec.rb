require "rails_helper"

RSpec.describe IndividualsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/individuals").to route_to("individuals#index")
    end

    it "routes to #new" do
      expect(get: "/individuals/new").to route_to("individuals#new")
    end

    it "routes to #show" do
      expect(get: "/individuals/1").to route_to("individuals#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/individuals/1/edit").to route_to("individuals#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/individuals").to route_to("individuals#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/individuals/1").to route_to("individuals#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/individuals/1").to route_to("individuals#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/individuals/1").to route_to("individuals#destroy", id: "1")
    end
  end
end
