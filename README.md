Crate API
----------

This is a light ruby wrapper for the Crate filesharing API

Contributing to Crate API
-------------------------
 
* You know the drill, fork, change, pull request if you so like!

Things undone
-------------

* The file part of the api is as of yet undone.
* Proper documentation which I'll be doing soon
* Tests to verify that everything is working
* There is probably some weirdness with the exception handling, will take another look

Usage
-----
 Require

    require 'crate_api'
 Create a client!

    client = CrateAPI.new("username", "password")
 Get some crates!

    crates = client.crates.all
 Look at their files!

    crates[0].files
 All crate and item object support getting their short url so...

    crates[0].short_url || crates[0].files[0].short_url
 Add a file to a crate!

    crates[0].add_file("/path/to/your/file")
 Destroy a crate or file!

    crates[0].destroy - NOTE: this will destroy all of the files contained within without warning
    crates[0].files[0].destroy
 Add a crate!

    client.crates.add("NameOfYourAwesomeCrate")
 That's about it for now!

Copyright
---------

Copyright (c) 2011 Brian Michel. See LICENSE.txt for
further details.
