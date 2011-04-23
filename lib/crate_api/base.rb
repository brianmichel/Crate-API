module CrateAPI
  class Base
    attr_accessor :auth
    API_VERSION = 1
    BASE_URL = "https://api.letscrate.com/#{API_VERSION}"
    FILES_URL = "#{BASE_URL}/files"
    CRATES_URL = "#{BASE_URL}/crates"
    SHORT_URL = "http://its.cr/%s"

    FILES_ACTIONS = {
      :upload => "upload.json",
      :list => "list.json",
      :show => "show/%s.json",
      :destroy => "destroy/%s.json"
    }
    
    def initialize(username, password)
      @auth = {:username => username, :password => password}
    end
    
    def call(url, verb, params)
      options.merge!({:basic_auth => @auth})
      resp = nil
      case verb
      when :get
        resp = HTTParty.get(url, options)
      when :post
        resp = HTTParty.post(url, options)
      end

      if resp.code == 200
        return resp.body
      end
    end
  end
end