module CrateAPI
  class CrateObject
    attr_reader :short_code, :name, :id

    def initialize(hash)
      @short_code = hash["short_code"]
      @name = hash["name"]
      @id = hash["id"]
    end

    def short_url
      return "#{CrateAPI::Base::SHORT_URL}" % ["#{@short_code}"]
    end
  end
end