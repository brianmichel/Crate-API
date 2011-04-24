module CrateAPI
  # NotValidUserError class which is raised due to bad credentials.
  class NotValidUserError < Exception
    
  end

  # Base class which is used to authenticate user and perform calls.
  #
  class Base
    include HTTMultiParty

    # @attr [Hash] :auth auth hash.
    attr_accessor :auth
    # Current API Version.
    API_VERSION = 1
    # Base URL Endpoint
    BASE_URL = "https://api.letscrate.com/#{API_VERSION}"
    # Authorization URL Endpoint.
    AUTH_URL = "#{BASE_URL}/users/authenticate.json"
    # Items URL Endpoint.
    ITEMS_URL = "#{BASE_URL}/files"
    # Crates URL Endpoint.
    CRATES_URL = "#{BASE_URL}/crates"
    # Short URL Placeholder String.
    SHORT_URL = "http://lts.cr/%s"
    
    # Default initializer for getting a Crates instance.
    # @return [CrateAPI::Crates] a new Crates instance.
    def crates(); @crates || CrateAPI::Crates.new(); end
    
    # Default initializer for getting a Items instance.
    # @return [CrateAPI::Items] a new Items instance.
    def items(); @items || CrateAPI::Items.new(); end
    
    # Default initializer for the CrateAPI Client
    #
    # @param [String] username username for the Crate user.
    # @param [String] password password for the Crate user.
    # @return [CrateAPI::Base] this will return the base class instance.
    # @raise [NotValidUserError] this will occur if the username/password pair is not valid.
    def initialize(username, password)
      raise NotValidUserError unless CrateAPI::Base.authorized?(username, password)
      @@auth = {:username => username, :password => password}
    end
    
    
    # Class method that return the response body of the call.
    # 
    # @param [String] url URL endpoint to make the call to.
    # @param [Symbol] verb HTTP verb used for call.
    # @param [Optional] params Hash of params used for call.
    # @return [Object] body object from the response.
    def self.call(url, verb, params={})
      params.merge!({:basic_auth => @@auth})
      resp = nil
      case verb
      when :get
        resp = self.get(url, params)
      when :post
        resp = self.post(url, params)
      end
      if resp.code == 200
        return resp.body
      end
    end
    
    # Class method that will return a boolean whether or not the user is authorized.
    #
    # @param [String] username Username to test for authorization.
    # @param [String] pass Password to test for authorization.
    # @return [Boolean] whether or not the user is authorized.
    def self.authorized?(user, pass)
      resp = self.get("#{AUTH_URL}", {:basic_auth => {:username => user, :password => pass}})
      if resp.code == 401
        return false
      end
      return true
    end
  end
end