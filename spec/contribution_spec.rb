require 'spec_helper'

describe "mutators" do
  
  it "should be able to create a contribution in the database" do
    repository = Repository.create(:owner => 'rails', :name => 'rails')
    contributor = Contributor.create(:login => 'leereilly')
    contribution = Contribution.create(:repository => repository, :contributor => contributor, :count => 6)
    puts contribution.inspect
  end
end