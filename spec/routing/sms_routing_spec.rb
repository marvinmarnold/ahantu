require "spec_helper"

describe SmsController do
  describe "routing" do

    it "routes to #index" do
      get("/sms").should route_to("sms#index")
    end

    it "routes to #new" do
      get("/sms/new").should route_to("sms#new")
    end

    it "routes to #show" do
      get("/sms/1").should route_to("sms#show", :id => "1")
    end

    it "routes to #edit" do
      get("/sms/1/edit").should route_to("sms#edit", :id => "1")
    end

    it "routes to #create" do
      post("/sms").should route_to("sms#create")
    end

    it "routes to #update" do
      put("/sms/1").should route_to("sms#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/sms/1").should route_to("sms#destroy", :id => "1")
    end

  end
end
