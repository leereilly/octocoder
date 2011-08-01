require 'spec_helper'

describe Foobar::Foo do
  
  def app
    @app ||= Foobar::Foo
  end

  describe "GET '/'" do
    it "should be successful" do
      get '/'
      last_response.should be_ok
    end
  end
end
