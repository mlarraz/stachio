require 'rails_helper'

module Stachio
  describe TemplatesController do
    routes { Stachio::Engine.routes }

    describe "routing" do

      it "routes to #index" do
        expect(get("/")).to route_to("stachio/templates#index")
      end

      it "routes to #new" do
        expect(get("/new")).to route_to("stachio/templates#new")
      end

      it "routes to #show" do
        expect(get("/1")).to route_to("stachio/templates#show", :id => "1")
      end

      it "routes to #edit" do
        expect(get("/1/edit")).to route_to("stachio/templates#edit", :id => "1")
      end

      it "routes to #create" do
        expect(post("/")).to route_to("stachio/templates#create")
      end

      it "routes to #update" do
        expect(put("/1")).to route_to("stachio/templates#update", :id => "1")
      end

      it "routes to #destroy" do
        expect(delete("/1")).to route_to("stachio/templates#destroy", :id => "1")
      end

    end
  end
end
