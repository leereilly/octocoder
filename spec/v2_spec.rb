require 'spec_helper'

describe CCS::V2 do
  
  def app
    @app ||= CCS::V2
  end
  
  # Valid owner, valid repo, valid user
  describe "GET '/sinatra/sinatra/leereilly'" do  
    it "should be successful" do
      get '/sinatra/sinatra/leereilly/'
      last_response.should be_ok
    end
    
    it "should find the correct number of contributions" do
      get '/sinatra/sinatra/leereilly/'
      last_response.body.should == '{"count":1}'
    end
    
    it "should be cached if it wasn't before" do
      
    end
  end
  
  # Valid owner, valid repo, invalid user
  describe "GET '/sinatra/sinatra/admin'" do  
    it "should find the correct number of contributions for a cached repo" do
      get '/sinatra/sinatra/admin/'
      last_response.body.should == '{"count":0}'
    end
    
    it "should find the correct number of contributions for an uncached repo" do
      get '/leereilly/leereilly.net/admin/'
      last_response.body.should == '{"count":0}'
    end
    
    it "should return an error if the repo doesn't exist" do
      get '/admin/schmadmin/schnarf-schnarf/'
      last_response.body.should == '{"error":"404 Resource Not Found"}'
    end
  end
end
