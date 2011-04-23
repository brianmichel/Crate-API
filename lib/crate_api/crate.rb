module CrateAPI
  class Crate < CrateObject
      attr_reader :files
      def initialize(hash)
        super(hash)
        @files = CrateAPI::Files.from_array(hash["files"])
      end
  end
end