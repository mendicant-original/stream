# This is where the service call is made to university-web
#
require 'open-uri'

module University

  class Service
    
    class << self
      attr_reader :base_uri, :uri_path
      attr_accessor :user, :password
      def base_uri=(uri)
        @base_uri = URI.parse(uri)
      end
      
      def uri_path=(pattern)
        @uri_path = pattern
      end
    end
    
    attr_reader :params
    
    def base_uri; self.class.base_uri; end
    
    def auth; [self.class.user, self.class.password]; end
    
    def uri_path
      return unless self.class.uri_path
      i = -1
      self.class.uri_path.gsub(/:(\w+)/) do |s|
        URI.escape(params[i+=1].to_s || $1)
      end
    end
    
    def uri
      path = uri_path
      return unless base_uri && path
      URI.join( base_uri.to_s, path )
    end
    
    def get(*args)
      hdrs = (Hash === args.last ? args.pop : {})
      hdrs = {:http_basic_authentication => auth}.merge(hdrs) if auth
      
      @params = args
      open(uri, hdrs) {|io| parse(io.read)}
    end

    def parse(body)
      body
    end
    
  end

  #TODO set user and password for basic auth via some config file + initializer
  
  class User < Service

    self.base_uri = 'http://university.rubymendicant.com'
    self.path = '/auth/:uid'    #for example
  
    attr_reader :github, :alumnus, :error
    
    def parse(body)
      hash = JSON.parse(body)
      %w{github alumnus error}.each do |key|
        instance_variable_set(":@#{key}", hash[key])
      end
    end
    
    def alumnus?; alumnus; end

    def exists?; github && error.nil?; end
    
  end
  
end

