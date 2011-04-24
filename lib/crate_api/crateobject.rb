module CrateAPI
  # Base class for Crate and Item objects
  # @abstract Subclass in order to get the basic +:short_code+ , +:name+ , +:id+ params that every object should have.
  class CrateObject
    # @attr_reader [String] short_code short code for constructing the short url.
    # @attr_reader [String] name name of the CrateObject that is being accessed.
    # @attr_reader [Integer] id the numeric id of the CrateObject that is being accessed.
    attr_reader :short_code, :name, :id
    
    # The default initializer for the CrateObject class
    #
    # @param [Hash] a hash of values used to initialize the CrateObject.
    # @option opts [String] :short_code short code for short url
    # @option opts [String] :name name of the object
    # @option opts [Integer] :id id of the object
    # @return [CrateObject] this will return an initialized CrateObject instance.
    def initialize(hash)
      @short_code = hash["short_code"]
      @name = hash["name"]
      @id = hash["id"]
    end
    
    # Will return the shortened url of a given object
    #
    # @return [String] shortened url string for a given object.
    def short_url
      return "#{CrateAPI::Base::SHORT_URL}" % ["#{@short_code}"]
    end
  end
end