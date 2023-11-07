require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/ratios", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # Ratio. As you add validations to Ratio, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Ratio.create! valid_attributes
      get ratios_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      ratio = Ratio.create! valid_attributes
      get ratio_url(ratio)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_ratio_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      ratio = Ratio.create! valid_attributes
      get edit_ratio_url(ratio)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Ratio" do
        expect {
          post ratios_url, params: { ratio: valid_attributes }
        }.to change(Ratio, :count).by(1)
      end

      it "redirects to the created ratio" do
        post ratios_url, params: { ratio: valid_attributes }
        expect(response).to redirect_to(ratio_url(Ratio.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Ratio" do
        expect {
          post ratios_url, params: { ratio: invalid_attributes }
        }.to change(Ratio, :count).by(0)
      end

    
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post ratios_url, params: { ratio: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested ratio" do
        ratio = Ratio.create! valid_attributes
        patch ratio_url(ratio), params: { ratio: new_attributes }
        ratio.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the ratio" do
        ratio = Ratio.create! valid_attributes
        patch ratio_url(ratio), params: { ratio: new_attributes }
        ratio.reload
        expect(response).to redirect_to(ratio_url(ratio))
      end
    end

    context "with invalid parameters" do
    
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        ratio = Ratio.create! valid_attributes
        patch ratio_url(ratio), params: { ratio: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested ratio" do
      ratio = Ratio.create! valid_attributes
      expect {
        delete ratio_url(ratio)
      }.to change(Ratio, :count).by(-1)
    end

    it "redirects to the ratios list" do
      ratio = Ratio.create! valid_attributes
      delete ratio_url(ratio)
      expect(response).to redirect_to(ratios_url)
    end
  end
end