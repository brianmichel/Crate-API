module CrateAPI
  class NotValidUserError < Exception
  end
  
  class Base
    include HTTMultiParty

    attr_accessor :auth
    API_VERSION = 1
    BASE_URL = "https://api.letscrate.com/#{API_VERSION}"
    AUTH_URL = "#{BASE_URL}/users/authenticate.json"
    ITEMS_URL = "#{BASE_URL}/files"
    CRATES_URL = "#{BASE_URL}/crates"
    SHORT_URL = "http://lts.cr/%s"
    def crates(); @crates || CrateAPI::Crates.new(); end
    def items(); @items || CrateAPI::Items.new(); end
    
    def initialize(username, password)
      raise NotValidUserError unless CrateAPI::Base.authorized?(username, password)
      @@auth = {:username => username, :password => password}
    end
    
    def self.call(url, verb, params={})
      puts params
      params.merge!({:basic_auth => @@auth})
      puts params
      resp = nil
      case verb
      when :get
        resp = self.get(url, params)
      when :post
        resp = self.post(url, params)
      end
      puts url
      puts "STATUS CODE: #{resp.code}"
      puts resp.request.options
      if resp.code == 200
        return resp.body
      end
    end
    
    def self.authorized?(u, p)
      resp = self.get("#{AUTH_URL}", {:basic_auth => {:username => u, :password => p}})
      if resp.code == 401
        return false
      end
      return true
    end
  end
end