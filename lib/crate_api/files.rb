module CrateAPI
  class Files
    FILES_ACTIONS = {
      :upload => "upload.json",
      :list => "list.json",
      :show => "show/%s.json",
      :destroy => "destroy/%s.json"
    }
    
    def self.from_array(array)
      files = Array.new
      array.each do |file|
        files.push(File.new(file))
      end
      return files
    end
  end
end