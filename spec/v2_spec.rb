require 'spec_helper'

describe CCS::V2 do
  
  def app
    @app ||= CCS::V2
  end
  
  # Valid owner, valid repo, valid user
  describe "GET '/sinatra/sinatra/leereilly'" do  
    it "should be successful" do
      get '/sinatra/sinatra/leerilly/'
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
    it "should find the correct number of contributions" do
      get '/sinatra/sinatra/admin/'
      last_response.body.should == '{"count":0}'
    end
  end
end
