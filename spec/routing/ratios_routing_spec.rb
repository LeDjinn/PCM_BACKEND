require "rails_helper"

RSpec.describe RatiosController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/ratios").to route_to("ratios#index")
    end

    it "routes to #new" do
      expect(get: "/ratios/new").to route_to("ratios#new")
    end

    it "routes to #show" do
      expect(get: "/ratios/1").to route_to("ratios#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/ratios/1/edit").to route_to("ratios#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/ratios").to route_to("ratios#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/ratios/1").to route_to("ratios#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/ratios/1").to route_to("ratios#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/ratios/1").to route_to("ratios#destroy", id: "1")
    end
  end
end
