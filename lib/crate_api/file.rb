module CrateAPI
  class File < CrateObject
      attr_reader :size
      def initialize(hash)
        super(hash)
        @size = hash["size"]
      end
      
      def destroy
      end
  end
end