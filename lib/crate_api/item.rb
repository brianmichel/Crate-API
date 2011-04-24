module CrateAPI
  # FileDestroyError which is raised when there is an issue destroying the file.
  class FileDestroyError < Exception
  end
  
  # Item class which is used to manipulate and represent a file blob which is inside of a Crate.
  class Item < CrateObject
      attr_reader :size
      # Default initializer for the Item object.
      #
      # @param [Hash] hash an item hash.
      # @return [CrateAPI::Item] a fully initialized Item object.
      def initialize(hash)
        super(hash)
        @size = hash["size"]
      end
      
      # Will destroy the given file.
      # 
      # @return [nil] this method should return nil if there are no issues.
      # @raise [FileDestroyError] an error and message describing what happened.
      def destroy
        response = JSON.parse(CrateAPI::Base.call("#{CrateAPI::Base::ITEMS_URL}/#{CrateAPI::Items::ITEM_ACTIONS[:destroy] % ["#{self.id}"]}", :post))
        raise FileDestroyError, response["message"] unless response["status"] != "failure"
      end
  end
end