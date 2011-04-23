require "httmultiparty"
require "JSON"

["base", "crateobject", "crate", "crates", "item", "items"].each do |inc|
  require File.join(File.dirname(__FILE__), "crate_api", inc)
end

module CrateAPI
  def self.new(username, password)
    CrateAPI::Base.new(username, password)
  end
end