#DataMapper.setup(:default, "mysql://octocoder:octocoder@octocoder.leereilly.net/octocoder")

# DataMapper.setup(:default, {
#    :adapter  => 'mysql',
#    :database => "reillylife",
#    :username => 'reillylife',
#    :password => "reillylife",
#    :host     => 'mysql.reillylife.com'
#  })
 
 # DataMapper.setup(:default, {
 #    :adapter  => 'mysql',
 #    :database => "octocoder",
 #    :username => 'octocoder',
 #    :password => 'octocoder',
 #    :host     => 'octocoder.leereilly.net'
 #  })
 
#DataMapper.setup(:default, 'sqlite::memory:')

#DataMapper.auto_migrate!

class Repository
  CACHE_EXPIRATION_TIME = 86400 # secs.
  
  include DataMapper::Resource
  
  property :id, Serial
  property :owner, String
  property :name, String
  property :created_at, DateTime
  property :updated_at, DateTime
  
  has n, :contributions
  has n, :contributors, :through => :contributions
  
  def stale?
    cache_expires_at = self.created_at.to_time.to_f + Repository::CACHE_EXPIRATION_TIME
    if self.created_at.to_time.to_f >= cache_expires_at
      return true
    else
      return false
    end
  end
end
