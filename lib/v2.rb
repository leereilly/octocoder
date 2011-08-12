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
        response = {:count => contributions}
      rescue => e
       response = {:error => e.message.to_s}
      end
      response.to_json
    end  
  end
end
