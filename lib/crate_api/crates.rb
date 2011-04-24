module CrateAPI
  # CrateLimitReachedError class which is raised when the user can no longer add a crate to their account due to restriction.
  class CrateLimitReachedError < Exception
  end

  # Crates class which is used to add, list, manipulate the Crates on a given account.
  class Crates
    # Hash of available actions to take upon the Crates endpoint.
    CRATE_ACTIONS = {
      :add => "add.json",
      :list => "list.json",
      :rename => "rename/%s.json",
      :destroy => "destroy/%s.json"
    }
    
    # Add a new crate. 
    # 
    # @param [String] name of the crate to add.
    # @return [nil] no output from this method is expected if everything goes right.
    def add(name)
      response = JSON.parse(CrateAPI::Base.call("#{CrateAPI::Base::CRATES_URL}/#{CRATE_ACTIONS[:add]}", :post, {:body => {:name => name}}))
      raise CrateLimitReachedError, response["message"] unless response["status"] != "failure"
    end

    # Get a list of crates (w/o files).
    # 
    # @return [Array] an array of crate objects.
    # @note This will not return crate objects with the files they contain. 
    # @see Crates#all
    def list
      hash = JSON.parse(CrateAPI::Base.call("#{CrateAPI::Base::CRATES_URL}/#{CRATE_ACTIONS[:list]}", :get))
      return Crates.from_array(hash["crates"])
    end
    
    # Get a list of crates (w/ files).
    #
    # @return [Array] an array of crate objects.
    def all
      hash = JSON.parse(CrateAPI::Base.call("#{CrateAPI::Base::ITEMS_URL}/#{CRATE_ACTIONS[:list]}", :get))
      return Crates.from_array(hash["crates"])
    end
    
    # Class method to return an array of crate objects.
    # 
    # @return [Array] an array of initialized Crate objects.
    def self.from_array(array)
      return [] unless array != nil
      crates = Array.new
      array.each do |crate|
        crates.push(Crate.new(crate))
      end
      return crates
    end
  end
end