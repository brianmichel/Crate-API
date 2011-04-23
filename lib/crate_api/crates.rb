module CrateAPI
  class CrateLimitReachedError < Exception
  end

  class Crates
    CRATE_ACTIONS = {
      :add => "add.json",
      :list => "list.json",
      :rename => "rename/%s.json",
      :destroy => "destroy/%s.json"
    }
    
    def add(name)
      response = JSON.parse(CrateAPI::Base.call("#{CrateAPI::Base::CRATES_URL}/#{CRATE_ACTIONS[:add]}", :post, {:body => {:name => name}}))
      raise CrateLimitReachedError, response["message"] unless response["status"] != "failure"
    end

    def list
      hash = JSON.parse(CrateAPI::Base.call("#{CrateAPI::Base::CRATES_URL}/#{CRATE_ACTIONS[:list]}", :get))
      return Crates.from_array(hash["crates"])
    end
    
    def all
      hash = JSON.parse(CrateAPI::Base.call("#{CrateAPI::Base::ITEMS_URL}/#{CRATE_ACTIONS[:list]}", :get))
      return Crates.from_array(hash["crates"])
    end
    
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