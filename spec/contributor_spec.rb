require 'spec_helper'

describe "mutators" do
  
  it "should be able to create a contributor in the database" do
    contributor = Contributor.create(:login => 'leereilly')
    puts contributor.inspect
  end
end