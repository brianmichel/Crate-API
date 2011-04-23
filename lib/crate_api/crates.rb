module CrateAPI
  class Crates
    CRATE_ACTIONS = {
      :add => "add.json",
      :list => "list.json",
      :rename => "rename/%s.json",
      :destroy => "destroy/%s.json"
    }

    def list
      hash = JSON.parse(CrateAPI::Base.call("#{CrateAPI::Base::CRATES_URL}/#{CRATE_ACTIONS[:list]}", :get))
      return Crates.from_array(hash["crates"])
    end
    
    def all
      hash = JSON.parse(CrateAPI::Base.call("#{CrateAPI::Base::FILES_URL}/#{CRATE_ACTIONS[:list]}", :get))
      return Crates.from_array(hash["crates"])
    end
    
    def self.from_array(array)
      crates = Array.new
      array.each do |crate|
        crates.push(Crate.new(crate))
      end
      return crates
    end
  end
end