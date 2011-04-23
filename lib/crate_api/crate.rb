module CrateAPI
  class CrateRenameError < Exception
  end
  
  class CrateDestroyError < Exception
  end
  
  class Crate < CrateObject
      attr_reader :files
      def initialize(hash)
        super(hash)
        @files = CrateAPI::Items.from_array(hash["files"])
      end
      
      def destroy
        response = JSON.parse(CrateAPI::Base.call("#{CrateAPI::Base::CRATES_URL}/#{CrateAPI::Crates::CRATE_ACTIONS[:destroy] % ["#{self.id}"]}", :post))
        raise CrateDestroyError, response["message"] unless response["status"] != "failure"
      end
      
      def rename(name)
        response = JSON.parse(CrateAPI::Base.call("#{CrateAPI::Base::CRATES_URL}/#{CrateAPI::Crates::CRATE_ACTIONS[:rename] % ["#{self.id}"]}", :post, {:body => {:name => name}}))
        raise CrateRenameError, response["message"] unless response["status"] != "failure"
      end
      
      def add_file(path)
        file = File.new(path)
        response = CrateAPI::Base.call("#{CrateAPI::Base::FILES_URL}/#{CrateAPI::Items::ITEM_ACTIONS[:upload]}", :post, {:body => {:file => file, :crate_id => @id}})
      end
  end
end