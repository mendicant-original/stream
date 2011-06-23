module UniversityWeb
  
  site = "http://university.rubymendicant.com"

  def self.service
    RestClient::Resource.new(site, SERVICE_ID, SERVICE_PASS)
  end
  
  class User < Struct.new(:github, :alumnus, :staff, :error)
          
    def self.find_by_github(nick)
      find(:github => nick).first
    end
    
    def initialize(hash)
      self.members.each {|k| self[k] = hash[k.to_s]}
    end
    
    private
    
    class << self
          
      def find(params = {})
        ::UniversityWeb.service["/users.json"].get "", 
            :params => params do |resp, req, result|
          
          # TODO handle error response?
          parse(resp).map {|hash| new(hash)}
        end
      end
      
      def parse(response)
        JSON.parse(response.to_s)
      end
    
    end
    
  end
  
end
