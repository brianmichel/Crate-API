module CrateAPI
  class Items
    ITEM_ACTIONS = {
      :upload => "upload.json",
      :list => "list.json",
      :show => "show/%s.json",
      :destroy => "destroy/%s.json"
    }
    
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