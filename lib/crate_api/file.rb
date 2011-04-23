module CrateAPI
  class File < CrateObject
      attr_reader :size
      def initialize(hash)
        super(hash)
        @size = hash["size"]
      end
      
      def destroy
        CrateAPI::Base.call("#{CrateAPI::Base::FILES_URL}/#{CrateAPI::Files::FILES_ACTIONS[:destroy] % ["#{self.id}"]}", :post)
      end
  end
end