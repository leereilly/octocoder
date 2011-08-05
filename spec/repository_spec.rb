require 'spec_helper'

describe "mutators" do
  
  it "should be able to create a repository in the database" do
    repository = Repository.create(:owner => 'rails', :name => 'rails')
  end
end