require 'spec_helper'

describe CCS::V2 do
  
  def app
    @app ||= CCS::V2
  end

  describe "GET '/'" do
    it "should be successful" do
      get '/'
      last_response.should be_ok
    end
  end
end
