module CrateAPI
  class Base
    attr_accessor :auth
    API_VERSION = 1
    BASE_URL = "https://api.letscrate.com/#{API_VERSION}"
    FILES_URL = "#{BASE_URL}/files"
    CRATES_URL = "#{BASE_URL}/crates"
    SHORT_URL = "http://lts.cr/%s"
    def crates(); @crates || CrateAPI::Crates.new(); end
    def files(); @files || CrateAPI::Files.new(); end
    
    def initialize(username, password)
      @@auth = {:username => username, :password => password}
    end
    
    def self.call(url, verb, params={})
      params.merge!({:basic_auth => @@auth})
      resp = nil
      case verb
      when :get
        resp = HTTParty.get(url, params)
      when :post
        resp = HTTParty.post(url, params)
      end
      puts url
      puts "STATUS CODE: #{resp.code}"
      if resp.code == 200
        return resp.body
      end
    end
  end
end