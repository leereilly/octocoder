class Contributor
  include DataMapper::Resource
  
  property :id, Serial
  property :login, String
  property :created_at, DateTime
  property :updated_at, DateTime
  
  has n, :contributions
  has n, :repositories, :through => :contributions
end