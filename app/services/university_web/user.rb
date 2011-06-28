module UniversityWeb
  
  SITE = "http://university.rubymendicant.com"

  def self.service
    RestClient::Resource.new(SITE, SERVICE_ID, SERVICE_PASS)
  end
  
  class User < Struct.new(:github, :alumnus, :staff, :error)
          
    PATH = "/users.json"
    
    def self.find_by_github(nick)
      find(:github => nick).first
    end
    
    def initialize(hash)
      self.members.each {|k| self[k] = hash[k.to_s]}
    end
    
    private
    
    class << self
          
      def find(params = {})
        resp = ::UniversityWeb.service[PATH].get "", 
                  :params => params
          
        # TODO handle error response?
        parse(resp).map {|hash| new(hash)}
      end
      
      def parse(response)
        JSON.parse(response.to_s)
      end
    
    end
    
  end
  
end
