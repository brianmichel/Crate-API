module CrateAPI
  class Crates
    CRATE_ACTIONS = {
      :add => "add.json",
      :list => "list.json",
      :rename => "rename/%s.json",
      :destroy => "destroy/%s.json"
    }

    def list
      hash =JSON.parse(CrateAPI::Base.call("#{CRATES_URL}/#{CRATE_ACTIONS[:list]}", :get))
      crates = Array.new
      hash["crates"].each do |crate|
        crates.push(Crate.new(crate))
      end
      return crates
    end
  end
end