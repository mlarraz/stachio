require "spec_helper"

module Stachio
  describe TemplatesController do
    describe "routing" do

      it "routes to #index" do
        get("/").should route_to("stachio/templates#index")
      end

      it "routes to #new" do
        get("/new").should route_to("stachio/templates#new")
      end

      it "routes to #show" do
        get("/1").should route_to("stachio/templates#show", :id => "1")
      end

      it "routes to #edit" do
        get("/1/edit").should route_to("stachio/templates#edit", :id => "1")
      end

      it "routes to #create" do
        post("/").should route_to("stachio/templates#create")
      end

      it "routes to #update" do
        put("/1").should route_to("stachio/templates#update", :id => "1")
      end

      it "routes to #destroy" do
        delete("/1").should route_to("stachio/templates#destroy", :id => "1")
      end

    end
  end
end
