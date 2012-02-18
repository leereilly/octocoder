require 'spec_helper'

describe CCS::V1 do
  before do
    Repository.all.destroy!
    Contribution.all.destroy!

    FakeWeb.register_uri(
      :get,
      "https://api.github.com/repos/rails/rails/contributors",
      :body => '[{"login":"leereilly","contributions":6}]'
    )
    FakeWeb.register_uri(
      :get,
      %r|https://api\.github\.com/repos/.*leeeeeee.*/contributors|,
      :body => '{"message":"Not Found"}',
      :status => ["404", "Not Found"]
    )
  end
  
  def app
    @app ||= CCS::V1
  end
  
  describe "GET '/'" do
    it "should be successful" do
      get '/'
      last_response.should be_ok
    end
    
    it "should return an 'alive' message" do
      get '/'
      last_response.body.should == '{"message":"alive"}'
    end
  end
  
  # Note: Validating username and repo names is beyond the
  #   scope of this service.
  
  # Valid owner, valid repo, valid user
  describe "GET '/rails/rails/leereilly'" do
    it "should be successful" do
      get '/rails/rails/leerilly/'
      last_response.should be_ok
    end
    
    it "should find the correct number of contributions" do
      get '/rails/rails/leereilly/'
      last_response.body.should == '{"count":6}'
    end
  end  
  
  # Valid owner, valid repo, invalid user
  describe "GET '/rails/rails/leeeeeeeereillllllllly'" do
    it "should be successful" do
      get '/rails/rails/leeeeeeeereillllllllly/' # code smell
      last_response.should be_ok
    end
    
    it "should find the correct number of contributions" do
      get '/rails/rails/leeeeeeeereillllllllly/' # code smell
      last_response.body.should == '{"count":0}'
    end
  end
  
  # Valid owner, invalid repo, invalid user
  describe "GET '/rails/leeeeeeeereillllllllly/leeeeeeeereillllllllly'" do
    it "should be successful" do
      get '/rails/leeeeeeeereillllllllly/leeeeeeeereillllllllly/' # code smell
      last_response.should be_ok
    end
    
    it "should find the correct number of contributions" do
      get '/rails/leeeeeeeereillllllllly/leeeeeeeereillllllllly/' # code smell
      last_response.body.should == '{"message":"Not Found"}'
    end
  end
  
  # invalid owner, invalid repo, invalid user
  describe "GET '/leeeeeeeereillllllllly/leeeeeeeereillllllllly/leeeeeeeereillllllllly'" do
    it "should be successful" do
      get '/leeeeeeeereillllllllly/leeeeeeeereillllllllly/leeeeeeeereillllllllly/' # code smell
      last_response.should be_ok
    end
    
    it "should find the correct number of contributions" do
      get '/leeeeeeeereillllllllly/leeeeeeeereillllllllly/leeeeeeeereillllllllly/' # code smell
      last_response.body.should == '{"message":"Not Found"}'
    end
  end
  
end
