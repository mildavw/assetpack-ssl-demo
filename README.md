Assumes Bundler and RVM (or system Ruby 1.9.3)

Also, you may need to add "127.0.0.1 localhost.ssl" to your hosts file

To see the bug run

`rackup`

load https://localhost:8443 and note that CSS and JS are loaded. Now run

`rackup -E production`

reload the page and see that CSS and JS are not loaded. You'll see requests for them and successful responses, but the data will be empty.
