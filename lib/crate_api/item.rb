module CrateAPI
  class FileDestroyError < Exception
  end
  class Item < CrateObject
      attr_reader :size
      def initialize(hash)
        super(hash)
        @size = hash["size"]
      end
      
      def destroy
        response = JSON.parse(CrateAPI::Base.call("#{CrateAPI::Base::ITEMS_URL}/#{CrateAPI::Items::ITEM_ACTIONS[:destroy] % ["#{self.id}"]}", :post))
        raise FileDestroyError, response["message"] unless response["status"] != "failure"
      end
  end
end