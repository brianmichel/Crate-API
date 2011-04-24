module CrateAPI
  # CrateRenameError class which is raised when there is a problem renaming a given Crate.
  class CrateRenameError < Exception
  end
  
  # CrateDestroyError class which is raised when there is a problem destroying a given Crate.
  class CrateDestroyError < Exception
  end
  
  # CrateFileAlreadyExistsError class which is raised when there is a problem uploading a file to a given Crate.
  class CrateFileAlreadyExistsError < Exception
  end

  # Crate object class which is used to manipulate the single Crate object.
  class Crate < CrateObject
      attr_reader :files
      def initialize(hash)
        super(hash)
        @files = CrateAPI::Items.from_array(hash["files"])
      end
      
      # Destroys the given crate object.
      #
      # @return [CrateDestroyError, nil] if there is an issue destroying the crate, an error will be raised with the message explaining why. 
      def destroy
        response = JSON.parse(CrateAPI::Base.call("#{CrateAPI::Base::CRATES_URL}/#{CrateAPI::Crates::CRATE_ACTIONS[:destroy] % ["#{self.id}"]}", :post))
        raise CrateDestroyError, response["message"] unless response["status"] != "failure"
      end
      
      # Renamed the given crate object.
      #
      # @return [CrateRenameError, nil] if there is an issue with renaming the crate, an error will be raised with the message explaining why.
      def rename(name)
        response = JSON.parse(CrateAPI::Base.call("#{CrateAPI::Base::CRATES_URL}/#{CrateAPI::Crates::CRATE_ACTIONS[:rename] % ["#{self.id}"]}", :post, {:body => {:name => name}}))
        raise CrateRenameError, response["message"] unless response["status"] != "failure"
      end
      
      # Add a file to the given crate object.
      #
      # @param [String] This is the path to the file that you wish to upload.
      # @return [CrateFileAlreadyExistsError, nil] if there is an issue uploading the file to the crate, an error will be raised with the message explaining why.
      def add_file(path)
        file = File.new(path)
        response = CrateAPI::Base.call("#{CrateAPI::Base::ITEMS_URL}/#{CrateAPI::Items::ITEM_ACTIONS[:upload]}", :post, {:body => {:file => file, :crate_id => @id}})
        raise CrateFileAlreadyExistsError, response["message"] unless response["status"] != "failure"
      end
  end
end