class Repository  
  include DataMapper::Resource
  
  property :id, Serial
  property :owner, String
  property :name, String
  property :created_at, DateTime
  property :updated_at, DateTime
  
  has n, :contributions

  def stale?
    time_now = DateTime.now
    cache_expires_at = self.updated_at + 1

    if time_now >= cache_expires_at
      return true
    else
      return false
    end
  end

  def refresh
    delete_cache
    create_cache
  end

  def delete_cache
    adapter = DataMapper.repository(:default).adapter
    adapter.execute("DELETE FROM contributions WHERE repository_id = #{self.id}")
    adapter.execute("DELETE FROM repositories WHERE id = #{self.id}")
  end

  def create_cache
    cache_contributors_from_github(self.id)
  end
  
  def cache_contributors_from_github(repository_id)
    contributors_text = RestClient.get "https://api.github.com/repos/#{self.owner}/#{self.name}/contributors"
    contributors_json = JSON.parse(contributors_text)
    
    contributors_json.each do |contributor|
      contribution = Contribution.create(:repository => Repository.get(repository_id), :user => contributor['login'], :count => contributor['contributions'])
    end
  end
  
  def self.get_contributions(owner, repo, user)
    contributions = 0
    repository = Repository.first(:owner => owner, :name => repo)
    
    if repository

      if repository.stale?
        repository.delete_cache
        repository = Repository.create(:owner => owner, :name => repo)
        repository.create_cache
        contributions = Contribution.first(:repository => repository, :user => user)['count']
      else
        contributions = Contribution.first(:user => user, :repository => repository)
        contributions = contributions['count']
      end
      
    else
      repository = Repository.create(:owner => owner, :name => repo)
      repository.create_cache
      contributions = Contribution.first(:repository => repository, :user => user)['count']
    end
    
    return contributions
  end
end
