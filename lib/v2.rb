require 'uri'
require 'net/http'
require 'net/https'

module CCS
  class V2< Sinatra::Base
    
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
        contributions = Repository::get_contributions(params[:owner], params[:repo], params[:user])
      rescue => e
       contributions = {:message => e.message}
      end
      
      response = {:count => contributions}
      response.to_json
    end  
  end
end
