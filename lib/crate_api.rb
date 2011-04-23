require "httparty"
require "JSON"

["base", "crate", "crates", "crateobject", "file"].each do |inc|
  require File.join(File.dirname(__FILE__), "crate_api", inc)
end

module CrateAPI
  def self.new(username, password)
    CrateAPI::Base.new(username, password)
  end
end