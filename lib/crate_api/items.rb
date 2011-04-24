module CrateAPI
  # Items class which is used to get a set of items from the service.
  class Items
    # Hash of available actions to take upon the Items endpoint.
    ITEM_ACTIONS = {
      :upload => "upload.json",
      :list => "list.json",
      :show => "show/%s.json",
      :destroy => "destroy/%s.json"
    }
    # Creates an array of Item objects.
    #
    # @param [Array] array to be used as the generation source.
    # @return [Array] either an empty array if the input array is nil or a fully inialized array of Item objects.
    def self.from_array(array)
      return [] unless array != nil
      files = Array.new
      array.each do |file|
        files.push(Item.new(file))
      end
      return files
    end
  end
end