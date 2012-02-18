require 'spec_helper'

describe CCS::V2 do
  before do
    Repository.all.destroy!
    Contribution.all.destroy!

    %w[sinatra/sinatra leereilly/leereilly.net].each do |r|
      FakeWeb.register_uri(
        :get,
        "https://api.github.com/repos/#{r}/contributors",
        :body => '[{"login":"leereilly","contributions":3}]'
      )
    end
  end

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
      last_response.body.should == '{"count":3}'
    end
    
    it "caches the repo" do
      get '/sinatra/sinatra/leereilly/'
      FakeWeb.last_request = nil
      get '/sinatra/sinatra/leereilly/'
      FakeWeb.last_request.should be_nil
    end
  end
  
  # Valid owner, valid repo, invalid user
  describe "GET '/sinatra/sinatra/admin'" do  
    it "should find the correct number of contributions for a cached repo" do
      get '/sinatra/sinatra/leereilly/'
      get '/sinatra/sinatra/admin/'
      last_response.body.should == '{"count":0}'
    end
    
    it "should find the correct number of contributions for an uncached repo" do
      get '/leereilly/leereilly.net/admin/'
      last_response.body.should == '{"count":0}'
    end
    
    it "should return an error if the repo doesn't exist" do
      FakeWeb.register_uri(
        :get,
        "https://api.github.com/repos/admin/schmadmin/contributors",
        :body => '{"message":"Not Found"}',
        :status => ["404", "Not Found"]
      )
      get '/admin/schmadmin/schnarf-schnarf/'
      last_response.body.should == '{"error":"404 Resource Not Found"}'
    end
  end
end
