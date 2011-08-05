require 'uri'
require 'net/http'
require 'net/https'

DataMapper.setup(:default, ENV['DATABASE_URL'] || 'sqlite3://my.db')
DataMapper.auto_upgrade!

module CCS
  class V2 < Sinatra::Base
    
    def self.new(*)
      super
    end
    
    get '/?' do
      content_type :json
      message = Hash.new
      message[:message] = 'alive'
      message.to_json
    end
    
    get '/:owner/:repo/?' do
      cached_repository = Repository.first(:owner => params[:owner], :name => params[:repo])
      
      if cached_repository
        if cached_repository.stale?
          cached_repository = cache_repository(:owner => params[:owner], :name => params[:name])
      else
        cached_repository = cache_repository(:owner => params[:owner], :name => params[:name])
      end
      return cached_repository
    end
    
    get '/:owner/:repo/:user/?' do
      content_type :json
      
      begin
        contributions = Hash.new
        contributions[:count] = 0
        repository = Repository.first(:owner => params[:owner], :name => params[:repo])
                                                                                                                                puts "Repo: #{params[:owner]}/#{params[:repo]}: #{params[:user]}"
        if repository
          cached_repository = Repository.first(:owner => params[:owner], :name => params[:repo])
                                                                                                                                puts "I found this repository!"          
          if cached_repository.stale?
                                                                                                                                puts "It's stale :-()"            
            contributions = create_and_replace_records( params[:owner], params[:repo], params[:user])
          else
                                                                                                                                puts "It's not stale"            
            cached_contributor = Contributor.first(:login => params['user'])
            cached_contribution = Contribution.first(:repository => cached_repository, :contributor => cached_contributor)
            contributions[:count] = cached_contribution.count
          end
        else  
                                                                                                                                puts "I'm creating this repository for the first time!"          
          contributions = create_and_replace_records( params[:owner], params[:repo], params[:user])
        end
      rescue => e
        e.to_json
      end
      contributions.to_json
    end
    
    
    def create_and_replace_records(owner, repo, login)
      contributions = Hash.new
      contributions[:count] = 0
      
      cached_repository = Repository.create(:owner => owner, :name => repo)
      contributors_text = RestClient.get "https://api.github.com/repos/#{owner}/#{repo}/contributors"
      contributors = JSON.parse(contributors_text)
      
      contributors.each do |contributor|
        cached_contributor = Contributor.first_or_create(:login => contributor['login'])
        cached_contributions = Contribution.create(:contributor => cached_contributor, :repository => cached_repository, :count => contributor['contributions'])
        contributions[:count] = contributor['contributions'] if contributor['login'] == params[:user]
      end
      return contributions
    end    
  end
end