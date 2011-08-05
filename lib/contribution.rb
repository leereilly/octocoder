class Contribution
  include DataMapper::Resource
  
  property :id, Serial
  property :count, Integer
  property :created_at, DateTime
  property :updated_at, DateTime
  
  belongs_to :repository,   :key => true
  belongs_to :contributor, :key => true
end