class Contribution
  include DataMapper::Resource
  
  property :id, Serial
  property :user, String
  property :count, Integer
  property :created_at, DateTime
  property :updated_at, DateTime
  
  belongs_to :repository
end