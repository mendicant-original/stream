module RMU
  module University
    
    site = "http://university.rubymendicant.com"
    
    class User < Struct.new(:github, :alumnus, :staff, :error)
            
      def self.find_by_github(nick)
        find :github => nick
      end
      
      def initialize(hash)
        self.members.each {|k| self[k] = hash[k.to_s]}
      end
      
      private
      
      def service
        RestClient::Resource.new(RMU::University.site, RMU::University::SERVICE_ID, RMU::University::SERVICE_PASS)
      end
      
      def find(params = {})
        service["/users"].get "", 
                              :accepts => 'application/json', 
                              :params => params do |resp, req, result|
          
          # TODO handle error response?
          new(parse(resp))
        end
      end
      
      def parse(response)
        JSON.parse(response.to_s)
      end
      
    end
  end
end