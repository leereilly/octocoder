require 'spec_helper'

describe Foobar::Bar do
  
  def app
    @app ||= Foobar::Bar
  end
  
  describe "GET '/'" do
    it "should be successful" do
      get '/'
      last_response.should be_ok
    end
  end
end
