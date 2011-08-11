require 'uri'
require 'net/http'
require 'net/https'

module CCS
  class V1 < Sinatra::Base
    
    def self.new(*)
      super
    end
    
    get '/' do
      content_type :json
      message = Hash.new
      message[:message] = 'alive'
      message.to_json
    end
    
    get '/:owner/:repo/:user/?' do
      content_type :json
      
      begin
        contributions = Hash.new
        contributions[:count] = 0
        contributors_text = RestClient.get "https://api.github.com/repos/#{params[:owner]}/#{params[:repo]}/contributors"
        contributors = JSON.parse(contributors_text)
        contributors.each do |contributor|
          if contributor['login'] == params[:user]
            contributions[:count] = contributor['contributions']
            break
          end
        end
        contributions.to_json
      rescue => e
        e.response
      end
    end
  end
end
