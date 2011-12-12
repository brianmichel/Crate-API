require "httmultiparty"
require "json"

["base", "crateobject", "crate", "crates", "item", "items"].each do |inc|
  require File.join(File.dirname(__FILE__), "crate_api", inc)
end

# The CrateAPI Gem is a lightweight Ruby interface to the Crate file-sharing site.
# @author Brian Michel
# A few examples will follow in order to get everyone up to speed.
#
# @example Create a new Crate client.
#   client = CrateAPI.new("username", "password")
# 
# @example Retreive all crates for a user.
#   crates = client.crates.all
#
# @example Create a new crate.
#   client.crate.add("YourNewAwesomeCrateName")
# 
# @example Upload a new file to a crate.
#   crates[0].add_file("/Path/to/your/file")
#
module CrateAPI
  # Default initializer for a new CrateAPI instace
  #
  # @param [String] Username for the client.
  # @param [String] password Password for the client.
  # @return [CrateAPI::Base] newly initialized CrateAPI::Base instace.
  def self.new(username, password)
    CrateAPI::Base.new(username, password)
  end
end